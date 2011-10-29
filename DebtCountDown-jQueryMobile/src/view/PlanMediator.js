var cafescribe = cafescribe || {};
cafescribe.view = cafescribe.view || {};
cafescribe.view.planMediator = cafescribe.view.planMediator || {};

//-----------------------------------------------------------------------------
//
// Properties
//
//-----------------------------------------------------------------------------

/**
 * @returns float
 */
cafescribe.view.planMediator.getId = function ()
{
	return parseInt($("#plan-id").val());
};

/**
 * @returns float
 */
cafescribe.view.planMediator.getExpenses = function ()
{
	return parseFloat($("#plan-expenses").val());
};

/**
 * 
 * @returns float
 */
cafescribe.view.planMediator.getIncome = function ()
{
	return parseFloat($("#plan-income").val());
};

/**
 * 
 * @returns string
 */
cafescribe.view.planMediator.getName = function ()
{
	return $("#plan-name").val();
};

//-----------------------------------------------------------------------------
//
// Event Handlers
//
//-----------------------------------------------------------------------------

/**
 * 
 */
cafescribe.view.planMediator.onClick = function()
{
	var plan = new cafescribe.model.plan();
	plan.id = cafescribe.view.planMediator.getId();
	plan.expenses = cafescribe.view.planMediator.getExpenses();
	plan.income = cafescribe.view.planMediator.getIncome();
	plan.name = cafescribe.view.planMediator.getName();
	
	if( plan.id )
	{
		cafescribe.controller.planController.editPlan(plan);
	}
	else
	{
		cafescribe.controller.planController.addPlan(plan);
	}
};

/**
 * 
 */
cafescribe.view.planMediator.onPageBeforeShow = function()
{
	var plan = cafescribe.model.planProxy.selectedPlan;
	
	if( !plan )
		plan = new cafescribe.model.plan();
	
	// reset the view
	$("#plan-id").val(plan.id);
	$("#plan-name").val(plan.name);
	$("#plan-income").val(plan.income);
	$("#plan-expenses").val(plan.expenses);
};

//-----------------------------------------------------------------------------
//
// Register
//
//-----------------------------------------------------------------------------

$("#plan-page").live('pagebeforeshow',cafescribe.view.planMediator.onPageBeforeShow);
$("#plan-submit-button").live('click',cafescribe.view.planMediator.onClick);
