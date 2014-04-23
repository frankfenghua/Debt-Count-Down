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
		window.planService.addPlan(JSON.stringify(plan, null, 2), onResult.name, onFault.name);
	};

	/**
	 * @param plan
	 * @param onResult
	 * @param onFault
	 */
	this.deletePlan = function(plan, onResult, onFault)
	{
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: "json",
			type: 'POST',
			data: {
				'service':'Plan',
				'action':'deletePlan',
				'pid':plan.pid
			},
			success: function(data, textStatus, jqXHR)
			{
				onResult(plan);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};

	/**
	 * Load all plans in the system
	 */
	this.loadAllPlans = function(onResult, onFault)
	{
		window.planService.loadAllPlans(onResult.name, onFault.name);
	};
	
	/**
	 * This doesn't need to be a service call because we can just pull it off 
	 * the in memory model
	 */
	this.loadPlan = function(planId, onResult, onFault)
	{
		var plan = dcd.model.planProxy.getPlanById(planId);
		
		onResult.callback(plan);
	};
	
	/**
	 * 
	 * @param plan
	 * @param onResult
	 * @param onFault
	 */
	this.updatePlan = function (plan, onResult, onFault)
	{
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: "json",
			type: 'POST',
			data: {
				'service':'Plan',
				'action':'updatePlan',
				'plan':{"name":plan.name, "pid":plan.pid}
			},
			success: function(data, textStatus, jqXHR)
			{
				onResult(plan);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};
};

dcd.services.planService = new PlanService();