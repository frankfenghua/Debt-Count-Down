var dcd = dcd || {};
dcd.view = dcd.view || {};

function ManageIncomesMediator()
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
		var list = dcd.model.budgetItemProxy.getIncomes();
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
			$('#incomes-continue-button').removeClass('ui-disabled');
		}
		else
		{
			$('#incomes-continue-button').addClass('ui-disabled');
		}
	};

	/**
	 *
	 */
	this.register = function()
	{
		$("#incomes-page").live('pagebeforeshow', this.onPageBeforeShow);
		$('#incomes-add-button').live('click', this.onAddBtnClick);
		$('.edit-income-link').live('click', this.onEditClick);
		$('.check-income-link').live('click', this.onCheckClick);
		$('#incomes-back-button').live('click', this.onBackClick);
		$('#incomes-continue-button').live('click', this.onContinueClick);
	};

	/**
	 * @param incomes
	 */
	this.reloadIncomes = function(incomes)
	{
		$("#income-list").html(incomes);
		$("#income-list").listview('refresh');

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

		dcd.controller.appController.changePage(dcd.enum.pages.addIncome);
	};

	/**
	 * @param event
	 */
	this.onBackClick = function(event)
	{
		dcd.controller.appController.changePage(dcd.enum.pages.manageDebts, {"reverse":true});
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
			dcd.controller.incomeController.updateActive(itemId, true);
		}
		else
		{
			btn.attr('data-theme', 'c');
			btn.attr('class', 'ui-btn ui-btn-up-c ui-btn-icon-notext ui-btn-corner-all ui-shadow');
			dcd.controller.incomeController.updateActive(itemId, false);
		}

		dcd.view.manageIncomesMediator.checkActive();
	};

	/**
	 * @param event
	 */
	this.onContinueClick = function(event)
	{
		dcd.controller.appController.changePage(dcd.enum.pages.manageExpenses);
	};

	/**
	 * @param event
	 */
	this.onEditClick = function(event)
	{
		var itemId = parseInt($(event.currentTarget).attr('value'));

		dcd.controller.incomeController.showItem(itemId);
	};

	/**
	 * @param event
	 */
	this.onPageBeforeShow = function(event)
	{
		dcd.controller.incomeController.loadAllIncomes();
	};
};

dcd.view.manageIncomesMediator = dcd.view.manageIncomesMediator || new ManageIncomesMediator();
dcd.view.manageIncomesMediator.register();