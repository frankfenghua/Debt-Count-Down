var cafescribe = cafescribe || {};
cafescribe.view = cafescribe.view || {};
cafescribe.view.managePlans = cafescribe.view.managePlans || {};

//-----------------------------------------------------------------------------
//
// Properties
//
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//
// Event Handlers
//
//-----------------------------------------------------------------------------

/**
 * 
 */
cafescribe.view.managePlans.onPageBeforeShow = function()
{
	// fetch plans
	cafescribe.controller.planController.loadAllPlans(cafescribe.view.managePlans.loadAllPlans_resultHandler, cafescribe.view.managePlans.loadAllPlans_faultHandler);
};

//-----------------------------------------------------------------------------
//
// Result Handlers
//
//-----------------------------------------------------------------------------

/**
 * @param plans
 */
cafescribe.view.managePlans.reloadPlans = function(plans)
{
	$("#plan-list").html(plans);
	$("#plan-list").listview('refresh');
};

//-----------------------------------------------------------------------------
//
// Fault Handlers
//
//-----------------------------------------------------------------------------

/**
 * @param error
 */
cafescribe.view.managePlans.loadAllPlans_faultHandler = function(error)
{
	alert("loadAllPlans_faultHandler");
};

//-----------------------------------------------------------------------------
//
// Register
//
//-----------------------------------------------------------------------------

$("#manage-page").live('pagebeforeshow',cafescribe.view.managePlans.onPageBeforeShow);