var cafescribe = cafescribe || {};
cafescribe.controller = cafescribe.controller || {};
cafescribe.controller.planController = cafescribe.controller.planController || {};

//-----------------------------------------------------------------------------
//
// Methods
//
//-----------------------------------------------------------------------------

/**
 * Loads all plans from server
 */
cafescribe.controller.planController.loadAllPlans = function()
{
	// do an ajax call
	cafescribe.services.planService.loadAllPlans(cafescribe.controller.planController.loadAllPlans_resultHandler, cafescribe.controller.planController.loadAllPlans_faultHandler);
};

//-----------------------------------------------------------------------------
//
// Result Handlers
//
//-----------------------------------------------------------------------------

/**
 * @param plans
 */
cafescribe.controller.planController.loadAllPlans_resultHandler = function(plans)
{
	var list = "<li>" + plans.name + "</li>";
	cafescribe.view.managePlans.reloadPlans(list);
};

//-----------------------------------------------------------------------------
//
// Fault Handlers
//
//-----------------------------------------------------------------------------

/**
 * @param error
 */
cafescribe.controller.planController.loadAllPlans_faultHandler = function(error)
{
	alert(error);
};