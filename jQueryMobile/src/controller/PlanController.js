var dcd = dcd || {};
dcd.controller = dcd.controller || {};

function PlanController()
{
	//-------------------------------------------------------------------------
	//
	// References
	//
	//-------------------------------------------------------------------------
	
	this.planService = dcd.services.planService;
	
	this.appController = dcd.controller.appController;
	
	this.planProxy = dcd.model.planProxy;
	
	// this might not be loaded yet, as we load views after controllers
	this.managePlansMediator = function()
	{
		return dcd.view.managePlansMediator;
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
		dcd.services.planService.addPlan(plan, this.addPlan_resultHandler, 
				this.faultHandler);
	};
	
	/**
	 * @param plan
	 */
	this.deletePlan = function(plan)
	{
		dcd.services.planService.deletePlan(plan, this.deletePlan_resultHandler, 
			this.faultHandler);
	};

	/**
	 * 
	 * @param plan
	 */
	this.editPlan = function(plan)
	{
		dcd.services.planService.updatePlan(plan, this.updatePlan_resultHandler, 
				this.faultHandler);
	};
	
	/**
	 * Loads all plans from server
	 */
	this.loadAllPlans = function()
	{
		dcd.services.planService.loadAllPlans(this.loadAllPlans_resultHandler, 
				this.faultHandler);
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
			dcd.services.planService.updatePlan(plan, this.saveAndCont_updatePlan_resultHandler, 
				this.faultHandler);
		}
		else
		{
			dcd.services.planService.addPlan(plan, this.saveAndCont_addPlan_resultHandler,
				this.faultHandler);
		}
	};
	
	/**
	 * 
	 * @param planId
	 */
	this.showPlan = function(planId)
	{
		dcd.services.planService.loadPlan(planId, this.loadPlan_resultHandler, 
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
		dcd.model.planProxy.addPlan(plan);
		
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