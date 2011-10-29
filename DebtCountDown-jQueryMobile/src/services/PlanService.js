var cafescribe = cafescribe || {};
cafescribe.services = cafescribe.services || {};
cafescribe.services.planService = cafescribe.services.planService || {};

//-----------------------------------------------------------------------------
//
// Methods
//
//-----------------------------------------------------------------------------

/**
 * 
 */
cafescribe.services.planService.addPlan = function(plan, onResult, onFault)
{
	// make service call to add new plan
	plan.id = cafescribe.model.planProxy.plans.length+1;
	onResult(plan);
};

/**
 * 
 */
cafescribe.services.planService.loadPlan = function(planId, onResult, onFault)
{
	var plan = cafescribe.model.planProxy.getPlanById(planId);
	
	onResult(plan);
};

/**
 * Load all plans in the system
 */
cafescribe.services.planService.loadAllPlans = function(onResult, onFault)
{
	var list = new Array();
	if( !cafescribe.model.planProxy.plans.length )
	{
		var json = jQuery.parseJSON('{"plans":[{"id":"1", "name":"Plan1", "expenses":"123.45", "income":"543.21"}, {"id":"3", "name":"Plan2", "expenses":"234.56", "income":"654.32"}]}');
		var plan;
		
		for( var i = 0; i < json.plans.length; i++ )
		{
			plan = new cafescribe.model.plan();
			plan.fromJSON( json.plans[i] );
			
			list[i] = plan;
		}
	}
	else
	{
		list = cafescribe.model.planProxy.plans;
	}
	
	onResult(list);
};

/**
 * 
 * @param plan
 * @param onResult
 * @param onFault
 */
cafescribe.services.planService.updatePlan = function (plan, onResult, onFault)
{
	onResult(plan);
};