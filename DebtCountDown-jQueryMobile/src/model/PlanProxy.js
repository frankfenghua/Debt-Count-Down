var dcd = dcd || {};
dcd.model = dcd.model || {};

function PlanProxy()
{
		
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
	
	this.plans = [];
	
	this.selectedPlan = null;
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * @param plan
	 */
	this.addPlan = function(plan)
	{
		if( !this.plans )
			this.plans = [];
		
		this.plans.push(plan);
	};
	
	/**
	 * 
	 * @param planId
	 * @returns plan
	 */
	this.getPlanById = function (planId)
	{
		return this.plans[this.getPlanIndex(planId)];
	};
	
	/**
	 * @param planId
	 * @returns integer
	 */
	this.getPlanIndex = function (planId)
	{
		for( var i = 0; i < this.plans.length; i++ )
		{
			if( this.plans[i].pid == planId)
				return i;
		}
		
		return -1;
	};
	
	/**
	 * @param plan
	 */
	this.removePlan = function (plan)
	{
		this.plans.splice(this.getPlanIndex(plan.pid), 1);
	};
	
	/**
	 * @param plan
	 */
	this.updatePlan = function (plan)
	{
		this.plans[this.getPlanIndex(plan.pid)] = plan;
	};

};

// make it a singleton
dcd.model.planProxy = dcd.model.planProxy || new PlanProxy();