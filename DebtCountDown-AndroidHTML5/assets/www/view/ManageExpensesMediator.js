var dcd = dcd || {};
dcd.view = dcd.view || {};

function ManageExpensesMediator()
{
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 *
	 */
	this.checkActive = function()
	{
		var list = dcd.model.budgetItemProxy.getExpenses();
		var active = false;

		for( var i = 0; i < list.length; i++ )
		{
			if( list[i].active )
			{
				active = true;
			}
		}

		if( active )
		{
			$('#expenses-continue-button').removeClass('ui-disabled');
		}
		else
		{
			$('#expenses-continue-button').addClass('ui-disabled');
		}
	};

	/**
	 *
	 */
	this.register = function()
	{
		$("#expenses-page").live('pagebeforeshow', this.onPageBeforeShow);
		$('#expenses-add-button').live('click', this.onAddBtnClick);
		$('.edit-expense-link').live('click', this.onEditClick);
		$('.check-expense-link').live('click', this.onCheckClick);
		$('#expenses-back-button').live('click', this.onBackClick);
		$('#expenses-continue-button').live('click', this.onContinueClick);
	};

	/**
	 * @param {string} expenses HTML string of li entries
	 */
	this.reloadExpenses = function(expenses)
	{
		$("#expense-list").html(expenses);
		$("#expense-list").listview('refresh');

		this.checkActive();
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
		dcd.model.budgetItemProxy.selectedItem = null;

		dcd.controller.appController.changePage(dcd.enum.pages.addExpense);
	};

	/**
	 * @param event
	 */
	this.onBackClick = function(event)
	{
		dcd.controller.appController.changePage(dcd.enum.pages.manageIncomes, {"reverse":true});
	};

	/**
	 * @param event
	 */
	this.onCheckClick = function(event)
	{
		var btn = $($(this).children('span').children('span')[1]);
		var itemId = parseInt($(event.currentTarget).attr('value'));

		if( btn.attr('data-theme') == 'c' )
		{
			btn.attr('data-theme', 'b');
			btn.attr('class', 'ui-btn ui-btn-up-b ui-btn-icon-notext ui-btn-corner-all ui-shadow');
			dcd.controller.expenseController.updateActive(itemId, true);
		}
		else
		{
			btn.attr('data-theme', 'c');
			btn.attr('class', 'ui-btn ui-btn-up-c ui-btn-icon-notext ui-btn-corner-all ui-shadow');
			dcd.controller.expenseController.updateActive(itemId, false);
		}

		dcd.view.manageExpensesMediator.checkActive();
	};

	/**
	 * @param event
	 */
	this.onContinueClick = function(event)
	{
		// dcd.controller.appController.changePage(dcd.enum.pages.manageExpenses);
	};

	/**
	 * @param event
	 */
	this.onEditClick = function(event)
	{
		var itemId = parseInt($(event.currentTarget).attr('value'));

		dcd.controller.expenseController.showExpense(itemId);
	};

	/**
	 * @param event
	 */
	this.onPageBeforeShow = function(event)
	{
		dcd.controller.expenseController.loadAllExpenses();
	};
};

dcd.view.manageExpensesMediator = dcd.view.manageExpensesMediator || new ManageExpensesMediator();
dcd.view.manageExpensesMediator.register();

