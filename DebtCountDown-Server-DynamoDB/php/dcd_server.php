<?php
require_once 'AWSSDKforPHP/sdk.class.php';
require_once 'services/PlanService.php';

// set the various include paths so we can have an easier time auto-loading
$appended_inc_path = './services';
set_include_path(get_include_path() . PATH_SEPARATOR . $appended_inc_path);


// Auto-load classes so you don't have to worry about managing requires
function __autoload($class) {
	echo $class;
	include_once $class . '.php';
}

CFCredentials::set(array(
	'production' => array(
		'key' => $_ENV["AWS_KEY"],
		'secret' => $_ENV['AWS_SECRET'],
		'default_cache_config' => 'apc',
		'certificate_authority' => false
	)
));

// Set a default action
$request_service = $_REQUEST['service'] . 'Service';
$request_action = $_REQUEST['action'];

$service = new $request_service;

if(is_callable(array($service,$request_action))) {
	call_user_func(array($service,$request_action), $_REQUEST);
}

?>
