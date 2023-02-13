<?php

function core_autoload($classname)
{
    if (file_exists(__DIR__ . '/core/' . $classname . '.php'))
        require __DIR__ . '/core/' . $classname . '.php';
    if (file_exists(__DIR__ . '/models/' . $classname . '.php'))
        require __DIR__ . '/models/' . $classname . '.php';
    if (file_exists(__DIR__ . '/controllers/' . $classname . '.php'))
        require __DIR__ . '/controllers/' . $classname . '.php';
    if (file_exists(__DIR__ . '/scorings/' . $classname . '.php'))
        require __DIR__ . '/scorings/' . $classname . '.php';
    if (file_exists(dirname(__FILE__).'/tools/equifax-reports/'.$classname.'.php'))
        require dirname(__FILE__).'/tools/equifax-reports/'.$classname.'.php';
    if (file_exists(dirname(__FILE__).'/factories/'.$classname.'.php'))
        require dirname(__FILE__).'/factories/'.$classname.'.php';
    if (file_exists(dirname(__FILE__).'/vendor/autoload.php'))
        require dirname(__FILE__).'/vendor/autoload.php';
}

spl_autoload_register('core_autoload');
