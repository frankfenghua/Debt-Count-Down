var dcd = dcd || {};
dcd.view = dcd.view || {};

function ManagePlansMediator()
{
	//-----------------------------------------------------------------------------
	//
	// References
	//
	//-----------------------------------------------------------------------------

	/**
	 * These references still aren't working, but this is how I'd like them to 
	 * be handled if possible
	 */
	this.appController = dcd.controller.appController;
	
	this.planController = dcd.controller.planController;
	
	this.planProxy = dcd.model.planProxy;
	
	//-----------------------------------------------------------------------------
	//
	// Properties
	//
	//-----------------------------------------------------------------------------
	
	//-----------------------------------------------------------------------------
	//
	// Register
	//
	//-----------------------------------------------------------------------------

	this.register = function()
	{
		$("#manage-plans-page").live('pagebeforeshow',this.onPageBeforeShow);
		$("#manage-plans-add-button").live('click',this.onAddBtnClick);
		$(".edit-plan-link").live('click',this.onEditClick);
	};
	
	//-----------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//-----------------------------------------------------------------------------
	
	/**
	 * 
	 */
	this.onAddBtnClick = function()
	{
		dcd.model.planProxy.selectedPlan = null;
		
		dcd.controller.appController.changePage(dcd.enum.pages.addPlan);
	};

	/**
	 * 
	 */
	this.onEditClick = function(event)
	{
		var planId = parseInt(event.currentTarget.attributes[0].value);
		
		dcd.controller.planController.showPlan(planId);
	};
	
	/**
	 * 
	 */
	this.onPageBeforeShow = function()
	{
		// fetch plans
		dcd.controller.planController.loadAllPlans();
	};
	
	//-----------------------------------------------------------------------------
	//
	// Result Handlers
	//
	//-----------------------------------------------------------------------------
	
	/**
	 * @param plans
	 */
	this.reloadPlans = function(plans)
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
	this.loadAllPlans_faultHandler = function(error)
	{
		alert("loadAllPlans_faultHandler");
	};

};

dcd.view.managePlansMediator = dcd.view.managePlansMediator || new ManagePlansMediator();
dcd.view.managePlansMediator.register();
