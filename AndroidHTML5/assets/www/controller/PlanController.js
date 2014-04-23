var dcd = dcd || {};
dcd.controller = dcd.controller || {};

function PlanController()
{
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
		dcd.services.planService.addPlan(plan, 
			{
				"callback":this.addPlan_resultHandler,
				"name":"dcd.controller.planController.addPlan_resultHandler"
			},
			{
				"callback":this.faultHandler,
				"name":"dcd.controller.planController.faultHandler"
			});
	};
	
	/**
	 * @param plan
	 */
	this.deletePlan = function(plan)
	{
		dcd.services.planService.deletePlan(plan, 
			{
				"callback":this.deletePlan_resultHandler,
				"name":"dcd.controller.planController.deletePlan_resultHandler"
			},
			{
				"callback":this.faultHandler,
				"name":"dcd.controller.planController.faultHandler"
			});
	};

	/**
	 * 
	 * @param plan
	 */
	this.editPlan = function(plan)
	{
		dcd.services.planService.updatePlan(plan, 
			{
				"callback":this.updatePlan_resultHandler, 
				"name":"dcd.controller.planController.updatePlan_resultHandler"
			},
			{
				"callback":this.faultHandler,
				"name":"dcd.controller.planController.faultHandler"
			});
	};
	
	/**
	 * Loads all plans from server
	 */
	this.loadAllPlans = function()
	{
		dcd.services.planService.loadAllPlans(
			{
				"callback":this.loadAllPlans_resultHandler,
				"name":"dcd.controller.planController.loadAllPlans_resultHandler" 
			},
			{
				"callback":this.faultHandler,
				"name":"dcd.controller.planController.faultHandler"
			});
	};

	/**
	 * @param plan
	 */
	this.save = function(plan)
	{
		if( plan.pid )
			this.editPlan(plan);
		else
			this.addPlan(plan);
	};

	/**
	 * @param plan
	 */
	this.saveAndCont = function(plan)
	{
		if( plan.pid )
		{
			dcd.services.planService.updatePlan(plan, 
				{
					"callback":this.saveAndCont_updatePlan_resultHandler,
					"name":"dcd.controller.planController.saveAndCont_updatePlan_resultHandler" 
				},
				{
					"callback":this.faultHandler,
					"name":"dcd.controller.planController.faultHandler"
				});
		}
		else
		{
			dcd.services.planService.addPlan(plan, 
				{
					"callback":this.saveAndCont_addPlan_resultHandler,
					"name":"dcd.controller.planController.saveAndCont_addPlan_resultHandler"
				},
				{
					"callback":this.faultHandler,
					"name":"dcd.controller.planController.faultHandler"
				});
		}
	};
	
	/**
	 * 
	 * @param planId
	 */
	this.showPlan = function(planId)
	{
		dcd.services.planService.loadPlan(planId, 
			{
				"callback":this.loadPlan_resultHandler,
				"name":"dcd.controller.planController.loadPlan_resultHandler",
			},
			{
				"callback":this.faultHandler,
				"name":"dcd.controller.planController.faultHandler"
			});
	};

	//-------------------------------------------------------------------------
	//
	// Result Handlers
	//
	//-------------------------------------------------------------------------

	/**
	 * @param plan
	 */
	this.addPlan_resultHandler = function (plan)
	{
//		dcd.model.planProxy.addPlan(plan);
		
		dcd.controller.appController.changePage(dcd.enum.pages.managePlans, {"reverse":true});
	};

	/**
	 * @param plan
	 */
	this.deletePlan_resultHandler = function(plan)
	{
		dcd.model.planProxy.removePlan(plan);

		dcd.controller.appController.changePage(dcd.enum.pages.managePlans, {"reverse":true});
	};
	
	/**
	 * @param plans
	 */
	this.loadAllPlans_resultHandler = function(plans)
	{
		// set plans on in-memory model
		dcd.model.planProxy.plans = plans;
		
		var list = "";
		
		for( var i = 0; i < plans.length; i++ )
		{
			list += '<li><a href="#" class="edit-plan-link" value="' 
				+ plans[i].pid + '">' + plans[i].name + "</a></li>";
		}
		
		dcd.view.managePlansMediator.reloadPlans(list);
	};
	
	/**
	 * 
	 * @param plan
	 */
	this.loadPlan_resultHandler = function(plan)
	{
		dcd.model.planProxy.selectedPlan = plan;
		
		dcd.controller.appController.changePage(dcd.enum.pages.editPlan);
	};

	/**
	 * @param plan
	 */
	this.saveAndCont_addPlan_resultHandler = function(plan)
	{
		dcd.model.planProxy.addPlan(plan);
		dcd.model.planProxy.selectedPlan = plan;

		dcd.controller.appController.changePage(dcd.enum.pages.manageDebts);
	};

	/**
	 * @param plan
	 */
	this.saveAndCont_updatePlan_resultHandler = function(plan)
	{
		dcd.model.planProxy.updatePlan(plan);

		dcd.controller.appController.changePage(dcd.enum.pages.manageDebts);
	};

	/**
	 * 
	 * @param plan
	 */
	this.updatePlan_resultHandler = function (plan)
	{
		dcd.model.planProxy.updatePlan(plan);
		
		dcd.controller.appController.changePage(dcd.enum.pages.managePlans, {"reverse":true});
	};

	//-------------------------------------------------------------------------
	//
	// Fault Handlers
	//
	//-------------------------------------------------------------------------

	/**
	 * @param error
	 */
	this.faultHandler = function(error)
	{
		alert(error);
	};
};

dcd.controller.planController = new PlanController();