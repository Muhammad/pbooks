"""
Loader for PBooks to use Schematronic

Copyright: Savonix Corporation
Author: Albert Lash
License: Affero GPL v3 or later
"""
import cgi
from time import gmtime, strftime
from cStringIO import StringIO
import time
import os
import libxml2
from beaker.middleware import SessionMiddleware
from beaker.middleware import CacheMiddleware

# Import classes
from schematronic.kernel.flow import Flow
from schematronic.kernel.initializer import Initializer
from schematronic.kernel.config import Config
from schematronic.kernel.fence import Fence

from schematronic.modules.handlers.xsl_pyx import XslHandler
from schematronic.modules.handlers.xml_pyx import XmlHandler
from schematronic.modules.handlers.query_pyx import Query


#from schematronic.modules.handlers.xsl import XslHandler
#from schematronic.modules.handlers.xml import XmlHandler
#from schematronic.modules.handlers.query import Query

try:
    import psyco
    psyco.full(memory=100)

except ImportError:
    pass

libxml2.initParser()



# What about the app config?
# "/var/www/dev/pbooks/apps/pbooks/config/config.xml"
# These shouldn't be in here anyway.
#config = etree.parse("/var/www/dev/pbooks/config/config.xml").getroot()
#config_list = []
#environ['SCRIPT_NAME'] = posixpath.dirname(environ['SCRIPT_NAME'])

thexsl   = XslHandler()
thexml   = XmlHandler()
thequery = Query()
myinit   = Initializer(thexsl,thexml,thequery)

#import hotshot
#prof = hotshot.Profile("/tmp/schema.log")


def _application(environ, start_response):
    prof.start()
    res = myapplication(environ, start_response)
    prof.stop()
    #prof.close()
    return res


def pbooks_app(environ, start_response):

    myinit.start(environ)

    qs_dict = cgi.parse_qs(environ['QUERY_STRING'], \
        keep_blank_values = True, strict_parsing = False)

    mynid = qs_dict.get('nid','index')[0]
    
    my_cache_key = mynid + environ["QUERY_STRING"]
    cache = environ['beaker.cache'].get_cache(my_cache_key)

    if( 'POST' in environ ):
        cache.clear()

    try:
        output = cache.get_value('value')
        duration = myinit.stop()
        output += '-- Beaker Cached ' + `duration`
        content_type = cache.get_value('content_type')
        cache_control = cache.get_value('cache_control')

    except KeyError:
        server_config = environ['server_config']
        app_config    = environ['app_config']
        myconfig = Config(server_config, app_config)
        config = myconfig.getConfig()

        theflow = Flow()

        theflow.start(qs_dict,environ)

        myinit.process_gate(mynid)
        output = myinit.display()
        content_type  = myinit.content_type
        cache_control = myinit.cache_control
        cache.set_value('value', output)
        cache.set_value('content_type', content_type)
        cache.set_value('cache_control', cache_control)

    if(qs_dict.get('view_flow','none')[0] == "true"):
        flowdump = theflow.toXml()
        output = output + "<textarea rows='14' cols='200'>"+flowdump+"</textarea>"


    """Simplest possible application object"""
    status = '200 OK'
    response_headers = [('Content-type',content_type),('Cache-Control',cache_control)]
    start_response(status, response_headers)
    return output


app_session = SessionMiddleware(pbooks_app, type='memory', data_dir='/tmp/')





application = CacheMiddleware(app_session, type='memory', data_dir='/tmp/cache')


"""
# Example conf:
# SetEnv demo.templates /usr/local/wsgi/templates
<IfModule mod_wsgi.c>
    WSGIScriptAlias /schematronic /var/www/dev/pbooks/apps/pbooks/dispatchers/wsgi/pbooks.wsgi
    WSGIProcessGroup schematronic
    WSGIDaemonProcess schematronic user=www-data group=www-data threads=2
    WSGIPythonOptimize 1
</IfModule>
"""
