var cafescribe = cafescribe || {};
cafescribe.model = cafescribe.model || {};
cafescribe.model.planProxy = cafescribe.model.planProxy || {};

	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
		
	/**
	 * @private
	 */
	cafescribe.model.planProxy.plans = [];

	/**
	 * @private
	 */
	cafescribe.model.planProxy.selectedPlan = null;
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * @param plan
	 */
	cafescribe.model.planProxy.addPlan = function(plan)
	{
		if( !cafescribe.model.planProxy.plans )
			cafescribe.model.planProxy.plans = [];
		
		cafescribe.model.planProxy.plans.push(plan);
	};
	
	/**
	 * 
	 * @param planId
	 * @returns plan
	 */
	cafescribe.model.planProxy.getPlanById = function (planId)
	{
		for( var i = 0; i < cafescribe.model.planProxy.plans.length; i++ )
		{
			if( cafescribe.model.planProxy.plans[i].id == planId)
				return cafescribe.model.planProxy.plans[i];
		}
		
		return null;
	}
	
	/**
	 * @param plan
	 * @returns integer
	 */
	cafescribe.model.planProxy.getPlanIndex = function (plan)
	{
		for( var i = 0; i < cafescribe.model.planProxy.plans.length; i++ )
		{
			if( cafescribe.model.planProxy.plans[i].id == plan.id)
				return i;
		}
		
		return -1;
	};
	
	/**
	 * @param plan
	 */
	cafescribe.model.planProxy.removePlan = function (plan)
	{
		cafescribe.model.planProxy.plans.splice(cafescribe.model.planProxy.getPlanIndex(plan), 1);
	};
	
	/**
	 * @param plan
	 */
	cafescribe.model.planProxy.updatePlan = function (plan)
	{
		cafescribe.model.planProxy.plans[cafescribe.model.planProxy.getPlanIndex(plan)] = plan;
	};
