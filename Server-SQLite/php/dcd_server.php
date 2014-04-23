<?php
// set the various include paths so we can have an easier time auto-loading
$appended_inc_path = './services';
set_include_path(get_include_path() . PATH_SEPARATOR . $appended_inc_path);

// Auto-load classes so you don't have to worry about managing requires
function __autoload($class) {
	include_once $class . '.php';
}

$test = new PlanService();

// Set a default action
$request_service = $_REQUEST['service'] . 'Service';
$request_action = $_REQUEST['action'];

$service = new $request_service;

if(is_callable(array($service,$request_action))) {
	call_user_func(array($service,$request_action), $_REQUEST);
}

?>