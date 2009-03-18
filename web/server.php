#!/usr/bin/php5-cgi
<?php

require "nanoserv/nanoserv.php";
require "nanoserv/handlers/NS_HTTP_Service_Handler.php";

class dumb_httpd extends NS_HTTP_Service_Handler {


    public function on_Request($url) {
        $descriptorspec = array(
           0 => array("pipe", "r"),  // stdin is a pipe that the child will read from
           1 => array("pipe", "w"),  // stdout is a pipe that the child will write to
           2 => array("file", "/tmp/error-output.txt", "a") // stderr is a file to write to
        );
        //$_SERVER = array('REQUEST_URI' => 'index.php');
        $process = proc_open("php5-cgi index.php", $descriptorspec, $pipes, "/var/www/dev/pbooks/web", $_SERVER);
        return stream_get_contents($pipes[1]);

        /*
        ob_start();
        var_dump($this->request_headers);
        $barf = ob_get_contents();
        return $barf;
        */
    }

}

$l = Nanoserv::New_Listener("tcp://0.0.0.0:800", "dumb_httpd");

$l->Set_Forking();
$l->Activate();

Nanoserv::Run();

?>
