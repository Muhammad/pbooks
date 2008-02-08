<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PBooks Open Source Accounting and Bookkeeping System</title>
<meta name="generator" content="Nexista 1.1">
<style>
html, body {
	color:           #444;
	background:      #EEE;
	font-weight:     normal;
	font-style:      normal;
	text-decoration: none;
	font-family: Arial, Helvetica, sans-serif; 
}
.simpletable { 
    background-color: #222;
    border-collapse: collapse;
    width: 100%;
}
table.simpletable thead th, table.simpletable tbody tr td{
	background-color: #FFF;
    padding: 4px;
    border: 1px;
    border-color: #555;
    border-style: solid;
}
table.simpletable td {
    width: 50%;
}
#container { 			
    margin: auto;
    width: 40%;
    background-color: white;
}
</style>
</head>
<body>
<div id="container">
<?php
/**
 * PHP Requirements Checker script
 *
 */

/**
 * PHP Requirements Checker script
 */

$php_version = "5.1.0";
$extensions = array("xsl"=>1,"mcrypt"=>0,"xcache"=>0);
$classes = array("DOMDocument"=>1);
$my_ext = get_loaded_extensions();


$ext_table = '<table class="simpletable">';
foreach($extensions as $extension => $required) { 
    $ext_table .= "<tr><td>".$extension."</td><td>";
    if(in_array($extension,$my_ext))
    {
        $ext_table .= "+";
    } else {
        $ext_table .= "x";
    }
    $ext_table .= "</td></tr>";
}
echo $ext_table;




?>
</div>
</body>
</html>