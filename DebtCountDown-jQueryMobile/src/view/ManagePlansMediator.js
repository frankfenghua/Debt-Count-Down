var cafescribe = cafescribe || {};
cafescribe.view = cafescribe.view || {};
cafescribe.view.managePlansMediator = cafescribe.view.managePlansMediator || {};

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
cafescribe.view.managePlansMediator.onEditClick = function(event)
{
	var planId = parseInt(event.currentTarget.attributes[0].value);
	
	cafescribe.controller.planController.showPlan(planId);
};

/**
 * 
 */
cafescribe.view.managePlansMediator.onPageBeforeShow = function()
{
	// fetch plans
	cafescribe.controller.planController.loadAllPlans();
};

/**
 * 
 */
cafescribe.view.managePlansMediator.onAddBtnClick = function()
{
	cafescribe.model.planProxy.selectedPlan = null;
	
	cafescribe.controller.appController.changePage(cafescribe.enum.pages.addPlan);
};

//-----------------------------------------------------------------------------
//
// Result Handlers
//
//-----------------------------------------------------------------------------

/**
 * @param plans
 */
cafescribe.view.managePlansMediator.reloadPlans = function(plans)
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
cafescribe.view.managePlansMediator.loadAllPlans_faultHandler = function(error)
{
	alert("loadAllPlans_faultHandler");
};

//-----------------------------------------------------------------------------
//
// Register
//
//-----------------------------------------------------------------------------

$("#manage-page").live('pagebeforeshow',cafescribe.view.managePlansMediator.onPageBeforeShow);
$("#manage-page-add-button").live('click',cafescribe.view.managePlansMediator.onAddBtnClick);
$(".edit-plan-link").live('click',cafescribe.view.managePlansMediator.onEditClick);
