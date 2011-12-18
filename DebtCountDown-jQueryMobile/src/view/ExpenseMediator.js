var dcd = dcd || {};
dcd.view = dcd.view || {};

function ExpenseMediator()
{
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------

	//---------------------------------
	// active
	//---------------------------------

	/**
	 * @returns boolean
	 */
	this.getActive = function()
	{
		return /^true$/i.test($('#expense-active').val());
	};

	/**
	 * @param {boolean} value
	 */
	this.setActive = function(value)
	{
		$('#expense-active').val(value);
	};

	//---------------------------------
	// amount
	//---------------------------------

	/**
	 * @returns {float}
	 */
	this.getAmount = function()
	{
		return parseFloat($('#expense-amount').val());
	};

	/**
	 * @param {float} value
	 */
	this.setAmount = function(value)
	{
		$('#expense-amount').val(value);
	};

	//---------------------------------
	// Expense
	//---------------------------------

	/**
	 * @returns {BudgetItemVO}
	 */
	this.getExpense = function()
	{
		var item = new BudgetItemVO();
		item.active = this.getActive();
		item.amount = this.getAmount();
		item.name = this.getName();
		item.pid = this.getPid();
		item.type = this.getType();

		return item;
	};

	/**
	 * @param {BudgetItemVO} value
	 */
	this.setExpense = function(value)
	{
		this.setActive(value.active);
		this.setAmount(value.amount);
		this.setName(value.name);
		this.setPid(value.pid);
		this.setType(value.type);
	};

	//---------------------------------
	// name
	//---------------------------------

	/**
	 * @returns string
	 */
	this.getName = function()
	{
		return $('#expense-name').val();
	};

	/**
	 * @param {string} value
	 */
	this.setName = function(value)
	{
		$('#expense-name').val(value);
	};

	//---------------------------------
	// pid
	//---------------------------------

	/**
	 * @returns integer
	 */
	this.getPid = function()
	{
		return parseInt($('#expense-pid').val());
	};

	/**
	 * @param {integer} value
	 */
	this.setPid = function(value)
	{
		$('#expense-pid').val(value);
	};

	//---------------------------------
	// type
	//---------------------------------

	/**
	 * @returns {string}
	 */
	this.getType = function()
	{
		return $('#expense-type').val();
	};

	/**
	 * @param {string} value
	 */
	this.setType = function(value)
	{
		$('#expense-type').val(value);
	};

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
		$('#expense-page').live('pagebeforeshow', this.onPageBeforeShow);
		$('#expense-delete-button').live('click', this.onDeleteBtnClick);
		$('#expense-page-back-button').live('click', this.onBackBtnClick);
		$('#expense-page-save-button').live('click', this.onSaveBtnClick);
	};

	//-------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//-------------------------------------------------------------------------

	/**
	 * @param event
	 */
	this.onBackBtnClick = function(event)
	{
		dcd.controller.appController.changePage(dcd.enum.pages.manageExpenses);
	};

	/**
	 * @param event
	 */
	this.onDeleteBtnClick = function(event)
	{
		var item = dcd.view.expenseMediator.getExpense();

		if( item.pid )
		{
			dcd.controller.expenseController.deleteExpense(item);
		}
	};

	/**
	 * @param event
	 */
	this.onPageBeforeShow = function(event)
	{
		var item = dcd.model.budgetItemProxy.selectedItem;

		if( !item )
		{
			item = new BudgetItemVO();
			item.active = true;
			item.type = dcd.enum.budgetItemTypes.expense;
		}

		dcd.view.expenseMediator.setExpense(item);
	};

	/**
	 * @param event
	 */
	this.onSaveBtnClick = function(event)
	{
		var item = dcd.view.expenseMediator.getExpense();

		dcd.controller.expenseController.save(item);
	};
};

dcd.view.expenseMediator = new ExpenseMediator();
dcd.view.expenseMediator.register();