var cafescribe = cafescribe || {};
cafescribe.view = cafescribe.view || {};

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
	this.appController = cafescribe.controller.appController;
	
	this.planController = cafescribe.controller.planController;
	
	this.planProxy = cafescribe.model.planProxy;
	
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
		$("#manage-page").live('pagebeforeshow',this.onPageBeforeShow);
		$("#manage-page-add-button").live('click',this.onAddBtnClick);
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
	this.onEditClick = function(event)
	{
		var planId = parseInt(event.currentTarget.attributes[0].value);
		
		cafescribe.controller.planController.showPlan(planId);
	};
	
	/**
	 * 
	 */
	this.onPageBeforeShow = function()
	{
		// fetch plans
		cafescribe.controller.planController.loadAllPlans();
	};
	
	/**
	 * 
	 */
	this.onAddBtnClick = function()
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

cafescribe.view.managePlansMediator = cafescribe.view.managePlansMediator || new ManagePlansMediator();
cafescribe.view.managePlansMediator.register();
