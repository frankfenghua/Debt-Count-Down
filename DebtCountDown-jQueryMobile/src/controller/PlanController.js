var cafescribe = cafescribe || {};
cafescribe.controller = cafescribe.controller || {};

function PlanController()
{
	//-------------------------------------------------------------------------
	//
	// References
	//
	//-------------------------------------------------------------------------
	
	this.planService = cafescribe.services.planService;
	
	this.appController = cafescribe.controller.appController;
	
	this.planProxy = cafescribe.model.planProxy;
	
	// this might not be loaded yet, as we load views after controllers
	this.managePlansMediator = function()
	{
		return cafescribe.view.managePlansMediator;
	};
	
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
		cafescribe.services.planService.addPlan(plan, this.addPlan_resultHandler, 
				this.faultHandler);
	};
	
	/**
	 * 
	 * @param plan
	 */
	this.editPlan = function(plan)
	{
		cafescribe.services.planService.updatePlan(plan, this.updatePlan_resultHandler, 
				this.faultHandler);
	};
	
	/**
	 * Loads all plans from server
	 */
	this.loadAllPlans = function()
	{
		cafescribe.services.planService.loadAllPlans(this.loadAllPlans_resultHandler, 
				this.faultHandler);
	};
	
	/**
	 * 
	 * @param planId
	 */
	this.showPlan = function(planId)
	{
		cafescribe.services.planService.loadPlan(planId, this.loadPlan_resultHandler, 
				this.faultHandler);
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
		cafescribe.model.planProxy.addPlan(plan);
		
		cafescribe.controller.appController.changePage(cafescribe.enum.pages.manage);
	};

	/**
	 * 
	 * @param plan
	 */
	this.updatePlan_resultHandler = function (plan)
	{
		cafescribe.model.planProxy.updatePlan(plan);
		
		cafescribe.controller.appController.changePage(cafescribe.enum.pages.manage);
	};
	
	/**
	 * @param plans
	 */
	this.loadAllPlans_resultHandler = function(plans)
	{
		// set plans on in-memory model
		cafescribe.model.planProxy.plans = plans;
		
		var list = "";
		
		for( var i = 0; i < plans.length; i++ )
		{
			list += '<li><a href="#" class="edit-plan-link" value="' 
				+ plans[i].id + '">' + plans[i].name + "</a></li>";
		}
		
		cafescribe.view.managePlansMediator.reloadPlans(list);
	};
	
	/**
	 * 
	 * @param plan
	 */
	this.loadPlan_resultHandler = function(plan)
	{
		cafescribe.model.planProxy.selectedPlan = plan;
		
		cafescribe.controller.appController.changePage(cafescribe.enum.pages.editPlan);
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

cafescribe.controller.planController = new PlanController();