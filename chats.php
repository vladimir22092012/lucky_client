<?php

error_reporting(-1);
ini_set('display_errors', 'On');

if (isset($_SERVER['HTTPS']) && ($_SERVER['HTTPS'] == 'on' || $_SERVER['HTTPS'] == 1) || isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
    $protocol = 'https';
} else {
    $protocol = 'http';
}

define('protocol', $protocol);
define('baseUrl', $_SERVER['SERVER_NAME']);
define('ROOT', __DIR__);

session_start();
if (isset($_GET['api'])) {
    $putchFile = ROOT . DIRECTORY_SEPARATOR . 'chats' . DIRECTORY_SEPARATOR . ucfirst(strtolower($_GET['api'] . '.php'));
    if (is_file($putchFile)) {
        include_once $putchFile;
    }
}

require_once 'core/Core.php';

class ApiChats extends Core {

    public function __construct() {
        if (isset($_GET['method'])) {
            $method = $_GET['method'];
        } else {
            $method = false;
        }

        if (isset($_GET['api'])) {
            $class = ucfirst(strtolower($_GET['api']));
            if (class_exists($class)) {
                $objClass = new $class();
                if (method_exists($objClass, $method)) {
                    $res = $objClass->$method();
                    if ($res) {
                        echo json_encode($res);
                    }
                }
            }
        }
    }

}

new ApiChats();
