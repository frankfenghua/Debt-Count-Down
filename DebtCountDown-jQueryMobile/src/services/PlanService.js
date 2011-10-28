var cafescribe = cafescribe || {};
cafescribe.services = cafescribe.services || {};
cafescribe.services.planService = cafescribe.services.planService || {};

//-----------------------------------------------------------------------------
//
// Methods
//
//-----------------------------------------------------------------------------

/**
 * Load all plans in the system
 */
cafescribe.services.planService.loadAllPlans = function(onResult, onFault)
{
	var json = '{"id":"1", "name":"Plan1", "expenses":"123.45", "income":"543.21"}';
	
	var plan = new cafescribe.model.plan();
	plan.fromJSON(json);
	
	onResult(plan);
};