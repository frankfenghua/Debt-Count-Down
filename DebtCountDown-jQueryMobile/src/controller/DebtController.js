var dcd = dcd || {};
dcd.controller = dcd.controller || {};

function DebtController()
{
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param debt
	 */
	this.addDebt = function(debt)
	{
		dcd.services.debtService.addDebt(debt, this.addDebt_resultHandler, 
			this.faultHandler);
	};

	/**
	 * @param debt
	 */
	this.deleteDebt = function(debt)
	{
		dcd.services.debtService.deleteDebt(debt, this.deleteDebt_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param debt
	 */
	this.editDebt = function(debt)
	{
		dcd.services.debtService.updateDebt(debt, this.updateDebt_resultHandler,
			this.faultHandler);
	};

	/**
	 *
	 */
	this.loadAllDebts = function()
	{
		dcd.services.debtService.loadAllDebts(this.loadAllDebts_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param debt
	 */
	this.save = function(debt)
	{
		if( debt.pid )
		{
			this.editDebt(debt);
		}
		else
		{
			this.addDebt(debt);
		}
	};

	/**
	 * @param debtId
	 */
	this.showDebt = function(debtId)
	{
		dcd.services.debtService.loadDebt(debtId, this.loadDebt_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param debtId
	 * @param active
	 */
	this.updateActive = function(debtId, active)
	{
		var debt = dcd.model.debtProxy.getDebtById(debtId);
		debt.active = active;

		dcd.services.debtService.updateDebt(debt, 
			this.updateActive_resultHandler, this.faultHandler);
	};

	//-------------------------------------------------------------------------
	//
	// Result Handlers
	//
	//-------------------------------------------------------------------------

	/**
	 * @param debt
	 */
	this.addDebt_resultHandler = function(debt)
	{
		dcd.model.debtProxy.addDebt(debt);
		dcd.model.debtProxy.selectedDebt = null;

		dcd.controller.appController.changePage(dcd.enum.pages.manageDebts);
	};

	/**
	 * @param debt
	 */
	this.deleteDebt_resultHandler = function(debt)
	{
		dcd.model.debtProxy.removeDebt(debt);
		dcd.model.debtProxy.selectedDebt = null;

		dcd.controller.appController.changePage(dcd.enum.pages.manageDebts, {"reverse":true});
	};

	/**
	 * @param debts
	 */
	this.loadAllDebts_resultHandler = function(debts)
	{
		dcd.model.debtProxy.debts = debts;

		var list = "";
		var theme = "c";

		for( var i = 0; i < debts.length; i++ )
		{
			if( debts[i].active )
			{
				theme = "b";
			}
			else
			{
				theme = 'c';
			}

			list += '<li><a href="#" class="edit-debt-link" value="' 
				+ debts[i].pid + '">' + debts[i].name + '</a><a href="#" '
				+ 'class="check-debt-link" data-theme="' + theme + '" value="' 
				+ debts[i].pid + '"></a></li>';
		}

		dcd.view.manageDebtsMediator.reloadDebts(list);
	};

	/**
	 * @param debt
	 */
	this.loadDebt_resultHandler = function(debt)
	{
		dcd.model.debtProxy.selectedDebt = debt;

		dcd.controller.appController.changePage(dcd.enum.pages.editDebt);
	};

	/**
	 * @param debt
	 */
	this.updateActive_resultHandler = function(debt)
	{
		dcd.model.debtProxy.updateDebt(debt);
	};

	/**
	 * @param debt
	 */
	this.updateDebt_resultHandler = function(debt)
	{
		dcd.model.debtProxy.updateDebt(debt);
		dcd.model.debtProxy.selectedDebt = null;

		dcd.controller.appController.changePage(dcd.enum.pages.manageDebts, {"reverse":true});
	};

	//-------------------------------------------------------------------------
	//
	// Fault Handlers
	//
	//-------------------------------------------------------------------------

	/**
	 * @param error
	 */
	this.faultHandler = function(error)
	{
		alert(error);
	};
};

dcd.controller.debtController = new DebtController();