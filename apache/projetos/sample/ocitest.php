<?php

//$conn = oci_connect('system', 'oracle', 'oracledb/XE');
$conn = oci_connect('system', 'oracle', 'oracledb/XE');

if ($conn === false) {
    $e = (object) oci_error();
    echo $e->codigo . ' - ' . $e->message;
} else
    echo 'succesful';
