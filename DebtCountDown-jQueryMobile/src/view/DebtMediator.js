var dcd = dcd || {};
dcd.view = dcd.view || {};

function DebtMediator()
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
		return /^true$/i.test($('#debt-active').val());
	};

	/**
	 * @param value
	 */
	this.setActive = function(value)
	{
		$('#debt-active').val(value);
	};

	//---------------------------------
	// apr
	//---------------------------------

	/**
	 * @returns float
	 */
	this.getApr = function()
	{
		return parseFloat($('#debt-apr').val());
	};

	/**
	 * @param value
	 */
	this.setApr = function(value)
	{
		$('#debt-apr').val(value);
	};

	//---------------------------------
	// balance
	//---------------------------------

	/**
	 * @returns float
	 */
	this.getBalance = function()
	{
		return parseFloat($('#debt-balance').val());
	};

	/**
	 * @param value
	 */
	this.setBalance = function(value)
	{
		$('#debt-balance').val(value);
	};

	//---------------------------------
	// bank
	//---------------------------------

	/**
	 * @returns string
	 */
	this.getBank = function()
	{
		return $('#debt-bank').val();
	};

	/**
	 * @param value
	 */
	this.setBank = function(value)
	{
		$('#debt-bank').val(value);
	}

	//---------------------------------
	// debt
	//---------------------------------

	/**
	 * @returns debt
	 */
	this.getDebt = function()
	{
		var debt = new DebtVO();
		debt.active = this.getActive();
		debt.apr = this.getApr();
		debt.balance = this.getBalance();
		debt.bank = this.getBank();
		debt.name = this.getName();
		debt.pid = this.getPid();
		// TODO: minPayment/paymentRate
		return debt;
	};

	/**
	 * @param value
	 */
	this.setDebt = function(value)
	{
		this.setActive(value.active);
		this.setApr(value.apr);
		this.setBalance(value.balance);
		this.setBank(value.bank);
		this.setName(value.name);
		this.setPid(value.pid);
	};

	//---------------------------------
	// minPayment
	//---------------------------------

	/**
	 * @returns float
	 */
	this.getMinPayment = function()
	{
		return parseFloat($('#debt-minPayment').val());
	};

	/**
	 * @param value
	 */
	this.setMinPayment = function(value)
	{
		$('#debt-minPayment').val(value);
	};

	//---------------------------------
	// name
	//---------------------------------

	/**
	 * @returns string
	 */
	this.getName = function()
	{
		return $('#debt-name').val();
	};

	/**
	 * @param value
	 */
	this.setName = function(value)
	{
		$('#debt-name').val(value);
	};

	//---------------------------------
	// pid
	//---------------------------------

	/**
	 * @returns integer
	 */
	this.getPid = function()
	{
		return parseInt($('#debt-pid').val());
	};

	/**
	 * @param value
	 */
	this.setPid = function(value)
	{
		$('#debt-pid').val(value);
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
		$('#debt-page').live('pagebeforeshow', this.onPageBeforeShow);
		$('#debt-delete-button').live('click', this.onDeleteBtnClick);
		$('#debt-page-back-button').live('click', this.onBackBtnClick);
		$('#debt-page-save-button').live('click', this.onSaveBtnClick);
		$('#debt-estimate-button').live('click', this.onEstimateBtnClick);
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
		dcd.controller.appController.changePage(dcd.enum.pages.manageDebts);
	};

	/**
	 * @param event
	 */
	this.onDeleteBtnClick = function(event)
	{
		var debt = dcd.view.debtMediator.getDebt();

		if( debt.pid )
		{
			dcd.controller.debtController.deleteDebt(debt);
		}
	};

	/**
	 * @param event
	 */
	this.onEstimateBtnClick = function(event)
	{
		dcd.view.debtMediator.setMinPayment(dcd.view.debtMediator.getDebt().estimateMinPayment());
	};

	/**
	 * @param event
	 */
	this.onPageBeforeShow = function(event)
	{
		var debt = dcd.model.debtProxy.selectedDebt;

		if( !debt )
		{
			debt = new DebtVO();
		}

		dcd.view.debtMediator.setDebt(debt);
	};

	/**
	 * @param event
	 */
	this.onSaveBtnClick = function(event)
	{
		var debt = dcd.view.debtMediator.getDebt();

		dcd.controller.debtController.save(debt);
	};
};

dcd.view.debtMediator = new DebtMediator();
dcd.view.debtMediator.register();