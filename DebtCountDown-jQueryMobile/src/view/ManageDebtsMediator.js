var dcd = dcd || {};
dcd.view = dcd.view || {};

function ManageDebtsMediator()
{
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 *
	 */
	this.register = function()
	{
		$("#manage-debts-page").live('pagebeforeshow', this.onPageBeforeShow);
		$('#manage-debts-add-button').live('click', this.onAddBtnClick);
		$('.edit-debt-link').live('click', this.onEditClick);
		$('.check-debt-link').live('click', this.onCheckClick);
		$('#manage-debts-back-button').live('click', this.onBackClick);
		$('#debts-continue-button').live('click', this.onContinueClick);
	};

	/**
	 * @param debts
	 */
	this.reloadDebts = function(debts)
	{
		$("#debt-list").html(debts);
		$("#debt-list").listview('refresh');
	};

	//-------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//-------------------------------------------------------------------------

	/**
	 * @param event
	 */
	this.onAddBtnClick = function(event)
	{
		dcd.model.debtProxy.selectedDebt = null;

		dcd.controller.appController.changePage(dcd.enum.pages.addDebt);
	};

	/**
	 * @param event
	 */
	this.onBackClick = function(event)
	{
		var plan = dcd.model.planProxy.selectedPlan;

		dcd.controller.planController.showPlan(plan.pid);
	};

	/**
	 * @param event
	 */
	this.onCheckClick = function(event)
	{
		var btn = $($(this).children('span').children('span')[1]);
		var debtId = parseInt(event.currentTarget.attributes[0].value);

		if( btn.attr('data-theme') == 'c' )
		{
			btn.attr('data-theme', 'b');
			btn.attr('class', 'ui-btn ui-btn-up-b ui-btn-icon-notext ui-btn-corner-all ui-shadow');
			dcd.controller.debtController.updateActive(debtId, true);
		}
		else
		{
			btn.attr('data-theme', 'c');
			btn.attr('class', 'ui-btn ui-btn-up-c ui-btn-icon-notext ui-btn-corner-all ui-shadow');
			dcd.controller.debtController.updateActive(debtId, false);
		}
	};

	/**
	 * @param event
	 */
	this.onContinueClick = function(event)
	{
		dcd.controller.appController.changePage(dcd.enum.pages.manageIncomes);
	};

	/**
	 * @param event
	 */
	this.onEditClick = function(event)
	{
		var debtId = parseInt(event.currentTarget.attributes[0].value);

		dcd.controller.debtController.showDebt(debtId);
	};

	/**
	 *
	 */
	this.onPageBeforeShow = function()
	{
		dcd.controller.debtController.loadAllDebts();
	};
};

dcd.view.manageDebtsMediator = dcd.view.manageDebtsMediator || new ManageDebtsMediator();
dcd.view.manageDebtsMediator.register();