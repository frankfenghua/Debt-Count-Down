var dcd = dcd || {};
dcd.services = dcd.services || {};

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
		plan.pid = dcd.model.planProxy.plans.length+1;
		onResult(plan);
	};

	/**
	 * @param plan
	 * @param onResult
	 * @param onFault
	 */
	this.deletePlan = function(plan, onResult, onFault)
	{
		onResult(plan);
	};

	/**
	 * Load all plans in the system
	 */
	this.loadAllPlans = function(onResult, onFault)
	{
		var list = new Array();
		if( !dcd.model.planProxy.plans.length )
		{
			var json = jQuery.parseJSON('{"plans":[{"pid":"1", "name":"Plan1", "expenses":"123.45", "income":"543.21"}, {"pid":"2", "name":"Plan2", "expenses":"234.56", "income":"654.32"}]}');
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
			list = dcd.model.planProxy.plans;
		}
		
		onResult(list);
	};
	
	/**
	 * 
	 */
	this.loadPlan = function(planId, onResult, onFault)
	{
		var plan = dcd.model.planProxy.getPlanById(planId);
		
		onResult(plan);
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

dcd.services.planService = new PlanService();