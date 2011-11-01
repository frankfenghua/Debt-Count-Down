var cafescribe = cafescribe || {};
cafescribe.model = cafescribe.model || {};

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
		
		this.push(plan);
	};
	
	/**
	 * 
	 * @param planId
	 * @returns plan
	 */
	this.getPlanById = function (planId)
	{
		for( var i = 0; i < this.plans.length; i++ )
		{
			if( this.plans[i].id == planId)
				return this.plans[i];
		}
		
		return null;
	};
	
	/**
	 * @param plan
	 * @returns integer
	 */
	this.getPlanIndex = function (plan)
	{
		for( var i = 0; i < this.plans.length; i++ )
		{
			if( this.plans[i].id == plan.id)
				return i;
		}
		
		return -1;
	};
	
	/**
	 * @param plan
	 */
	this.removePlan = function (plan)
	{
		this.plans.splice(this.getPlanIndex(plan), 1);
	};
	
	/**
	 * @param plan
	 */
	this.updatePlan = function (plan)
	{
		this.plans[this.getPlanIndex(plan)] = plan;
	};

};

// make it a singleton
cafescribe.model.planProxy = cafescribe.model.planProxy || new PlanProxy();