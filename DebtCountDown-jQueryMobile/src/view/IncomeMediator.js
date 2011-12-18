var dcd = dcd || {};
dcd.view = dcd.view || {};

function IncomeMediator()
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
		return /^true$/i.test($('#income-active').val());
	};

	/**
	 * @param {boolean} value
	 */
	this.setActive = function(value)
	{
		$('#income-active').val(value);
	};

	//---------------------------------
	// amount
	//---------------------------------

	/**
	 * @returns {float}
	 */
	this.getAmount = function()
	{
		return parseFloat($('#income-amount').val());
	};

	/**
	 * @param {float} value
	 */
	this.setAmount = function(value)
	{
		$('#income-amount').val(value);
	};

	//---------------------------------
	// income
	//---------------------------------

	/**
	 * @returns {BudgetItemVO}
	 */
	this.getIncome = function()
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
	this.setIncome = function(value)
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
		return $('#income-name').val();
	};

	/**
	 * @param {string} value
	 */
	this.setName = function(value)
	{
		$('#income-name').val(value);
	};

	//---------------------------------
	// pid
	//---------------------------------

	/**
	 * @returns integer
	 */
	this.getPid = function()
	{
		return parseInt($('#income-pid').val());
	};

	/**
	 * @param {integer} value
	 */
	this.setPid = function(value)
	{
		$('#income-pid').val(value);
	};

	//---------------------------------
	// type
	//---------------------------------

	/**
	 * @returns {string}
	 */
	this.getType = function()
	{
		return $('#income-type').val();
	};

	/**
	 * @param {string} value
	 */
	this.setType = function(value)
	{
		$('#income-type').val(value);
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
		$('#income-page').live('pagebeforeshow', this.onPageBeforeShow);
		$('#income-delete-button').live('click', this.onDeleteBtnClick);
		$('#income-page-back-button').live('click', this.onBackBtnClick);
		$('#income-page-save-button').live('click', this.onSaveBtnClick);
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
		dcd.controller.appController.changePage(dcd.enum.pages.manageIncomes);
	};

	/**
	 * @param event
	 */
	this.onDeleteBtnClick = function(event)
	{
		var item = dcd.view.incomeMediator.getIncome();

		if( item.pid )
		{
			dcd.controller.incomeController.deleteIncome(item);
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
			item.type = dcd.enum.budgetItemTypes.income;
		}

		dcd.view.incomeMediator.setIncome(item);
	};

	/**
	 * @param event
	 */
	this.onSaveBtnClick = function(event)
	{
		var item = dcd.view.incomeMediator.getIncome();

		dcd.controller.incomeController.save(item);
	};
};

dcd.view.incomeMediator = new IncomeMediator();
dcd.view.incomeMediator.register();