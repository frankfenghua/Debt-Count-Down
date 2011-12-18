var dcd = dcd || {};
dcd.view = dcd.view || {};

function PlanMediator()
{
	
	//-----------------------------------------------------------------------------
	//
	// Properties
	//
	//-----------------------------------------------------------------------------
	
	/**
	 * @returns integer
	 */
	this.getId = function ()
	{
		return parseInt($("#plan-pid").val());
	};
	
	/**
	 * 
	 * @returns string
	 */
	this.getName = function ()
	{
		return $("#plan-name").val();
	};

	/**
	 * @returns plan
	 */
	this.getPlan = function ()
	{
		var plan = new PlanVO();
		plan.pid = dcd.view.planMediator.getId();
		plan.name = dcd.view.planMediator.getName();

		return plan;
	};
	
	//-----------------------------------------------------------------------------
	//
	// Methods
	//
	//-----------------------------------------------------------------------------
	
	this.register = function()
	{
		$("#plan-page").live('pagebeforeshow',this.onPageBeforeShow);
		$("#plan-continue-button").live('click',this.onContinueBtnClick);
		$("#plan-delete-button").live('click',this.onDeleteBtnClick);
		$('#plan-page-back-button').live('click', this.onBackBtnClick);
		$('#plan-page-save-button').live('click', this.onSaveBtnClick);
		$('#plan-name').live('keyup', this.planName_keyHandler);
	};
	
	//-----------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//-----------------------------------------------------------------------------
	
	/**
	 *
	 */
	this.onBackBtnClick = function()
	{
		dcd.model.planProxy.selectedPlan = null;
		dcd.controller.appController.changePage(dcd.enum.pages.managePlans, {"reverse":true});
	}

	/**
	 * This can't use 'this' because in the scope/context of the event handler,
	 * 'this' actually refers to "#plan-continue-button" and not the PlanMediator
	 * object.
	 */
	this.onContinueBtnClick = function()
	{
		var plan = dcd.view.planMediator.getPlan();
		
		dcd.controller.planController.saveAndCont(plan);
	};
	
	/**
	 *
	 */
	this.onDeleteBtnClick = function()
	{
		var plan = dcd.view.planMediator.getPlan();

		if( plan.pid )
		{
			dcd.controller.planController.deletePlan(plan);
		}
	};

	/**
	 * 
	 */
	this.onPageBeforeShow = function()
	{
		var plan = dcd.model.planProxy.selectedPlan;
		
		if( !plan )
			plan = new PlanVO();
		
		// reset the view
		$("#plan-pid").val(plan.pid);
		$("#plan-name").val(plan.name);

		if( !plan.name || !plan.name.length )
		{
			$('#plan-continue-button').addClass('ui-disabled');
			$('#plan-page-save-button').addClass('ui-disabled');
		}
		else
		{
			$('#plan-continue-button').removeClass('ui-disabled');
			$('#plan-page-save-button').removeClass('ui-disabled');
		}

		if( !plan.pid )
		{
			$('#plan-delete-button').addClass('ui-disabled');
		}
		else
		{
			$('#plan-delete-button').removeClass('ui-disabled');
		}
	};

	this.onSaveBtnClick = function()
	{
		var plan = dcd.view.planMediator.getPlan();

		dcd.controller.planController.save(plan);
	};

	/**
	 * @param event
	 */
	this.planName_keyHandler = function(event)
	{
		if( $('#plan-name').val().length )
		{
			$('#plan-continue-button').removeClass('ui-disabled');
			$('#plan-page-save-button').removeClass('ui-disabled');
		}
		else
		{
			$('#plan-continue-button').addClass('ui-disabled');
			$('#plan-page-save-button').addClass('ui-disabled');
		}
	};
};

dcd.view.planMediator = new PlanMediator();
dcd.view.planMediator.register();