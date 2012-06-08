<?php

// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

// Ensure library/ is on include_path
set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/../library'),
    '/usr/share/php/libzend-framework-php',
    get_include_path(),
)));

/** Zend_Application */
require_once 'Zend/Application.php';
require_once APPLICATION_PATH . '/configs/aws.config.php';
require_once 'AWSSDKforPHP/sdk.class.php';

CFCredentials::set(array(
	'production' => array(
		'key' => AWS_KEY,
		'secret' => AWS_SECRET,
		'default_cache_config' => 'apc',
		'certificate_authority' => false
	)
));

// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);
$application->bootstrap()
            ->run();