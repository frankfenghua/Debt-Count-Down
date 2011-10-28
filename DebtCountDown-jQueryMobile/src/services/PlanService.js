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
	var json = jQuery.parseJSON('{"plans":[{"id":"1", "name":"Plan1", "expenses":"123.45", "income":"543.21"}, {"id":"3", "name":"Plan2", "expenses":"234.56", "income":"654.32"}]}');
	var list = new Array();
	var plan;
	
	for( var i = 0; i < json.plans.length; i++ )
	{
		plan = new cafescribe.model.plan();
		plan.fromJSON( json.plans[i] );
		
		list[i] = plan;
	}
	
	onResult(list);
};