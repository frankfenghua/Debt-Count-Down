var cafescribe = cafescribe || {};
cafescribe.view = cafescribe.view || {};

function PlanMediator()
{
	
	//-----------------------------------------------------------------------------
	//
	// Properties
	//
	//-----------------------------------------------------------------------------
	
	/**
	 * @returns float
	 */
	this.getId = function ()
	{
		return parseInt($("#plan-id").val());
	};
	
	/**
	 * @returns float
	 */
	this.getExpenses = function ()
	{
		return parseFloat($("#plan-expenses").val());
	};
	
	/**
	 * 
	 * @returns float
	 */
	this.getIncome = function ()
	{
		return parseFloat($("#plan-income").val());
	};
	
	/**
	 * 
	 * @returns string
	 */
	this.getName = function ()
	{
		return $("#plan-name").val();
	};
	
	//-----------------------------------------------------------------------------
	//
	// Methods
	//
	//-----------------------------------------------------------------------------
	
	this.register = function()
	{
		$("#plan-page").live('pagebeforeshow',this.onPageBeforeShow);
		$("#plan-submit-button").live('click',this.onClick);
	};
	
	//-----------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//-----------------------------------------------------------------------------
	
	/**
	 * This can't use 'this' because in the scope/context of the event handler,
	 * 'this' actually refers to "#plan-submit-button" and not the PlanMediator
	 * object.
	 */
	this.onClick = function()
	{
		var plan = new PlanVO();
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
	this.onPageBeforeShow = function()
	{
		var plan = cafescribe.model.planProxy.selectedPlan;
		
		if( !plan )
			plan = new PlanVO();
		
		// reset the view
		$("#plan-id").val(plan.id);
		$("#plan-name").val(plan.name);
		$("#plan-income").val(plan.income);
		$("#plan-expenses").val(plan.expenses);
	};
};

cafescribe.view.planMediator = new PlanMediator();
cafescribe.view.planMediator.register();