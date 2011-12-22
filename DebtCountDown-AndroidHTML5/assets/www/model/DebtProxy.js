var dcd = dcd || {};
dcd.model = dcd.model || {};

function DebtProxy()
{
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------

	this.debts = [];
	
	this.selectedDebt = null;

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
		if( !this.debts )
			this.debts = [];

		this.debts.push(debt);
	};

	/**
	 * @param debtId
	 * @return debt
	 */
	this.getDebtById = function(debtId)
	{
		return this.debts[this.getDebtIndex(debtId)];
	};

	/**
	 * @param debtId
	 * @return integer
	 */
	this.getDebtIndex = function(debtId)
	{
		for( var i = 0; i < this.debts.length; i++ )
		{
			if( this.debts[i].pid == debtId )
				return i;
		}

		return -1;
	};

	/**
	 * @param debt
	 */
	this.removeDebt = function(debt)
	{
		this.debts.splice(this.getDebtIndex(debt.pid), 1);
	};

	/**
	 * @param debt
	 */
	this.updateDebt = function(debt)
	{
		this.debts[this.getDebtIndex(debt.pid)] = debt;
	};
};

dcd.model.debtProxy = dcd.model.debtProxy || new DebtProxy();