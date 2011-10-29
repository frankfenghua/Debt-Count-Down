var cafescribe = cafescribe || {};
cafescribe.controller = cafescribe.controller || {};
cafescribe.controller.planController = cafescribe.controller.planController || {};

//-----------------------------------------------------------------------------
//
// Methods
//
//-----------------------------------------------------------------------------

/**
 * @param plan
 */
cafescribe.controller.planController.addPlan = function(plan)
{
	cafescribe.services.planService.addPlan(plan, cafescribe.controller.planController.addPlan_resultHandler, cafescribe.controller.planController.faultHandler);
};

/**
 * 
 * @param plan
 */
cafescribe.controller.planController.editPlan = function(plan)
{
	cafescribe.services.planService.updatePlan(plan, cafescribe.controller.planController.updatePlan_resultHandler, cafescribe.controller.planController.faultHandler);
};

/**
 * Loads all plans from server
 */
cafescribe.controller.planController.loadAllPlans = function()
{
	cafescribe.services.planService.loadAllPlans(cafescribe.controller.planController.loadAllPlans_resultHandler, cafescribe.controller.planController.faultHandler);
};

/**
 * 
 * @param planId
 */
cafescribe.controller.planController.showPlan = function(planId)
{
	cafescribe.services.planService.loadPlan(planId, cafescribe.controller.planController.loadPlan_resultHandler, cafescribe.controller.planController.faultHandler);
};

//-----------------------------------------------------------------------------
//
// Result Handlers
//
//-----------------------------------------------------------------------------

/**
 * @param plan
 */
cafescribe.controller.planController.addPlan_resultHandler = function (plan)
{
	cafescribe.model.planProxy.addPlan(plan);
	
	cafescribe.controller.appController.changePage(cafescribe.enum.pages.manage);
};

/**
 * 
 * @param plan
 */
cafescribe.controller.planController.updatePlan_resultHandler = function (plan)
{
	cafescribe.model.planProxy.updatePlan(plan);
	
	cafescribe.controller.appController.changePage(cafescribe.enum.pages.manage);
};

/**
 * @param plans
 */
cafescribe.controller.planController.loadAllPlans_resultHandler = function(plans)
{
	// set plans on in-memory model
	cafescribe.model.planProxy.plans = plans;
	
	var list = "";
	
	for( var i = 0; i < plans.length; i++ )
	{
		list += '<li><a href="#" class="edit-plan-link" value="' + plans[i].id + '">' + plans[i].name + "</a></li>";
	}
	
	cafescribe.view.managePlansMediator.reloadPlans(list);
};

/**
 * 
 * @param plan
 */
cafescribe.controller.planController.loadPlan_resultHandler = function(plan)
{
	cafescribe.model.planProxy.selectedPlan = plan;
	
	cafescribe.controller.appController.changePage(cafescribe.enum.pages.editPlan);
};

//-----------------------------------------------------------------------------
//
// Fault Handlers
//
//-----------------------------------------------------------------------------

/**
 * @param error
 */
cafescribe.controller.planController.faultHandler = function(error)
{
	alert(error);
};