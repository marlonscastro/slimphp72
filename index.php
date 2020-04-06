<?php

    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Headers: *');
    header('Access-Control-Allow-Methods: POST, PUT, GET, DELETE');
        
    header('Content-Type: application/json');

    require_once 'vendor/autoload.php';
    require_once 'env.php';
    require_once 'Config/slimConfig.php';
    require_once 'Config/auth.php';
    require_once 'Routes/index.php';

?>