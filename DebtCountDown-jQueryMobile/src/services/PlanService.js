var cafescribe = cafescribe || {};
cafescribe.services = cafescribe.services || {};

function PlanService()
{
	//-------------------------------------------------------------------------
	//
	// References
	//
	//-------------------------------------------------------------------------
	
	//-----------------------------------------------------------------------------
	//
	// Methods
	//
	//-----------------------------------------------------------------------------
	
	/**
	 * 
	 */
	this.addPlan = function(plan, onResult, onFault)
	{
		// make service call to add new plan
		plan.id = cafescribe.model.planProxy.plans.length+1;
		onResult(plan);
	};
	
	/**
	 * 
	 */
	this.loadPlan = function(planId, onResult, onFault)
	{
		var plan = cafescribe.model.planProxy.getPlanById(planId);
		
		onResult(plan);
	};
	
	/**
	 * Load all plans in the system
	 */
	this.loadAllPlans = function(onResult, onFault)
	{
		var list = new Array();
		if( !cafescribe.model.planProxy.plans.length )
		{
			var json = jQuery.parseJSON('{"plans":[{"id":"1", "name":"Plan1", "expenses":"123.45", "income":"543.21"}, {"id":"3", "name":"Plan2", "expenses":"234.56", "income":"654.32"}]}');
			var plan;
			
			for( var i = 0; i < json.plans.length; i++ )
			{
				plan = new PlanVO();
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
	this.updatePlan = function (plan, onResult, onFault)
	{
		onResult(plan);
	};
};

cafescribe.services.planService = new PlanService();