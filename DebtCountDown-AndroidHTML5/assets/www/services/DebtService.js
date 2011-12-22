var dcd = dcd || {};
dcd.services = dcd.services || {};

function DebtService()
{
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param debt
	 * @param onResult
	 * @param onFault
	 */
	this.addDebt = function(debt, onResult, onFault)
	{
		debt.pid = dcd.model.debtProxy.debts.length+1;
		onResult(debt);
	};

	/**
	 * @param debt
	 * @param onResult
	 * @param onFault
	 */
	this.deleteDebt = function(debt, onResult, onFault)
	{
		onResult(debt);
	};

	/**
	 * @param onResult
	 * @param onFault
	 */
	this.loadAllDebts = function(onResult, onFault)
	{
		var list = new Array();
		if( !dcd.model.debtProxy.debts.length )
		{
			var json = jQuery.parseJSON('{"debts":[{"pid":"1", "name":"Debt 1", "apr":"14.000", "balance":"12345.67", "paymentRate":"0.3"}]}');
			var debt;

			for( var i = 0; i < json.debts.length; i++ )
			{
				debt = new DebtVO();
				debt.fromJSON( json.debts[i] );

				list.push(debt);
			}
		}
		else
		{
			list = dcd.model.debtProxy.debts;
		}

		onResult(list);
	};

	/**
	 * @param debtId
	 * @param onResult
	 * @param onFault
	 */
	this.loadDebt = function(debtId, onResult, onFault)
	{
		var debt = dcd.model.debtProxy.getDebtById(debtId);

		onResult(debt);
	};

	/**
	 * @param debt
	 * @param onResult
	 * @param onFault
	 */
	this.updateDebt = function(debt, onResult, onFault)
	{
		onResult(debt);
	};
};

dcd.services.debtService = new DebtService();