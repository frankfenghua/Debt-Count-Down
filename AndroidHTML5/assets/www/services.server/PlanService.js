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
		$.ajax({
			url: "server/dcd_server.php",
			dataType: "json",
			type: 'POST',
			data: {
				"service":"Plan",
				"action":"addPlan",
				"name":plan.name
			},
			success: function(data, textStatus, jqXHR)
			{
				var newPlan = new PlanVO();
				newPlan.fromJSON(data);
				onResult(newPlan);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
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
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: "json",
			data: {
				'service':'Plan',
				'action':'loadAllPlans'
			},
			success: function(data, textStatus, jqXHR)
			{
				var json = data;
				var plan;
				var list = new Array();

				for( var i = 0; i < json.length; i++ )
				{
					plan = new PlanVO();
					plan.fromJSON( json[i] );
					
					list.push(plan);
				}

				onResult(list);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};
	
	/**
	 * This doesn't need to be a service call because we can just pull it off 
	 * the in memory model
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