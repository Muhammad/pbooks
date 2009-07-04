#!/bin/sh
# Program: PBooks
# Component: runtime.php
# Copyright: Savonix Corporation
# Author: Albert L. Lash, IV
# License: Gnu Affero Public License version 3

cat /var/www/dev/pbooks/config/config.xml | sed "s/&//g" > /var/www/dev/pbooks/config/config_noent.xml
xsltproc --param datasource_id 'pbooks_read' lua_tables.xsl /var/www/dev/pbooks/config/config_noent.xml > config.lua
