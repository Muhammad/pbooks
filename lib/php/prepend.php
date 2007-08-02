<?php

/* 

In development you will never do client side caching, but on every stage you will do 
server side caching. 

*/

Init::registerOutputHandler('gzBuffer');


function gzBuffer($init)
{
	$init->process();
	
	ob_start();
	ob_start('ob_gzhandler');
	
	$expiryTime=$init->getInfo('cacheExpiryTime');
	$agent = $_SERVER['HTTP_USER_AGENT'];
	if(stripos($agent,"google") || stripos($agent,"slurp") || stripos($agent,"msnbot") || stripos($agent,"spider") || stripos($agent,"bot")) { 		
		$my_user_id = -1000;
	} else { 
		$my_user_id = $_SESSION['NX_AUTH']['user_id'];
	}

	$my_request_uri = $_SERVER['REQUEST_URI'];
	$clear_gate_file='cache_'.$my_user_id."_".$my_request_uri;
	if(!include('Cache/Lite.php')) { 
        echo "can't find cache lite";
        exit;   
    }
	
	$options = array('cacheDir'=>NX_PATH_CACHE,'caching'  => 1,'lifeTime' => $expiryTime);
	$cache = new Cache_Lite($options);
	if(strpos($_SERVER['REQUEST_URI'],"server") || strpos($_SERVER['REQUEST_URI'],"gantt")) { 
		$file_server_status="yes";
	} else { 
		$file_server_status="no";
	}	
	development_console();
	if(isset($_SESSION['NX_AUTH']['real_account_id']) && $file_server_status!="yes") { 
		cs_console();
	}
    
	// Server cache! Always on, controlled by sitemap.
	// Server cache especially helpful for ssl connections.
	if($output = $cache->get($my_request_uri, $my_user_id, FALSE)) { 
		$cache_type = "File";
		// Check file mtime, and potentially return 304 response code.
		// Only for testing and production sites.
		$mynid = NX_PATH_CACHE.'cache_'.md5($my_user_id).'_'.md5($my_request_uri); 		
		$last_modified_str = filemtime($mynid);
		$file_size = filesize($mynid);
		$etag = md5($last_modified_str);
		$last_modified = gmdate('D, d M Y H:i:s', $last_modified_str);
		
		$request = getallheaders(); 
		if (isset($request['If-Modified-Since'])) { 
		   $modifiedSince = explode(';', $request['If-Modified-Since']); 
		   $modifiedSince = strtotime($modifiedSince[0]); 
		} else { 
		   $modifiedSince = 0; 
		}
		// Client cache! Only on for...
		if ($last_modified_str <= $modifiedSince) {
			while (@ob_end_clean());
			header("HTTP/1.0 304 Not Modified");
			exit;
		}	
		
		header("Last-Modified: " . $last_modified . " GMT");
	
	} else { 
		header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
		$output = $init->run();
		/* Write the output to cache, only if its not encrypted data. */
		$encrypt = Path::get("//get_wiki_page/encrypt", "flow"); 
		if($expiryTime > 2 && $encrypt!="1" && $_GET['view_flow']!=true) { 
			$cache->save($output, $my_request_uri, $my_user_id);
		}
		$cache_type = "None";
	}	
	if($_GET['view_flow']=="true"){
		view_flow();
	}
	
	header("ETag: ".$etag);
	echo $output;
	final_notices($cache_type,"dev");
	
	
	ob_end_flush();
	
	
	header("Content-Length: ".ob_get_length());
	ob_end_flush();
	
	
	
	
	
}
 













/* This function used by all stages. */
function cs_console()  {
	$blah = new XsltProcessor();
	$xsl = new DomDocument;
	$xsl->load(NX_PATH_APPS."_shared/xsl/impersonate_header.xsl");
	$blah->importStyleSheet($xsl);
	$flow = Flow::singleton();
	$user_name=$_SESSION['NX_AUTH']['user_name'];
	Flow::add("user_name",$user_name);
	echo $blah->transformToXML($flow->flowDocument);
}


/* This function only used on development stage. */
function development_console()  {

	$blah = new XsltProcessor();
	$xsl = new DomDocument;
	$xsl->load(NX_PATH_CORE."xsl/dev_prepend.xsl");
	$blah->importStyleSheet($xsl);
	$flow = Flow::singleton();
	$request_uri = $_SERVER['REQUEST_URI'];
	Flow::add("request_uri",$request_uri);
	echo $blah->transformToXML($flow->flowDocument);

}
 
function view_flow() { 
	$debugXsl = new XsltProcessor();
	$xsl = new DomDocument;
	$xsl->load(NX_PATH_CORE."xsl/flow.xsl");
	$debugXsl->importStyleSheet($xsl);
	$flow = Flow::singleton();
	echo $debugXsl->transformToXML($flow->flowDocument);
}


/* This function used on dev and test development stages. */
function final_notices($cacher=null, $mode) { 
	$my_total_time = Debug::profile();
	$final_notices =  "<div width='100%' 
    style='background: #e3b6ec; padding: 3px; position: absolute; top: 0px; right: 0px;'>
		Elapsed Server Time: $my_total_time , Elapsed Client Time:  
<script type='text/javascript'>

done_loading();</script> - Server cache: $cacher <!--[ <a href='/acc/cache/purge/'>Purge</a> ]--> </div>";
	echo $final_notices;
}


function authLogin($auth)
{
    if(empty($_SESSION['authReferer']))
    {
        $_SESSION['authReferer'] = $_SERVER['REQUEST_URI'];
    }
    $link_prefix = dirname(NX_LINK_PREFIX);
    header("Location: ".$link_prefix."/auth.php?nid=login");
    exit;
}

Auth::registerTimeoutHandler('authLogin');
Auth::registerLoginHandler('authLogin');
Auth::registerDeniedHandler('authLogin');
Auth::registerExpiredHandler('authLogin');