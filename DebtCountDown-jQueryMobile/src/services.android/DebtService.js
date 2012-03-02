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
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: 'json',
			type: 'POST',
			data: {
				'service':'Debt',
				'action':'addDebt',
				'debt':{'name':debt.name, 'bank':debt.bank, 'balance':debt.balance, 'apr':debt.apr, 'paymentRate':debt.paymentRate, 'active':debt.active},
				'planId':dcd.model.planProxy.selectedPlan.pid
			},
			success: function(data, textStatus, jqXHR)
			{
				debt.pid = data.pid;
				onResult(debt);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};

	/**
	 * @param debt
	 * @param onResult
	 * @param onFault
	 */
	this.deleteDebt = function(debt, onResult, onFault)
	{
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: 'json',
			type: 'POST',
			data: {
				'service':'Debt',
				'action':'deleteDebt',
				'pid':debt.pid,
				'planId':dcd.model.planProxy.selectedPlan.pid
			},
			success: function(data, textStatus, jqXHR)
			{
				onResult(debt);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};

	/**
	 * @param onResult
	 * @param onFault
	 */
	this.loadAllDebts = function(onResult, onFault)
	{
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: 'json',
			data: {
				'service':'Debt',
				'action':'loadAllDebts',
				'planId':dcd.model.planProxy.selectedPlan.pid // TODO: move this to a param
			},
			success: function(data, textStatus, jqXHR)
			{
				var debt;
				var list = new Array();

				for( var i = 0; i < data.length; i++ )
				{
					debt = new DebtVO();
					debt.fromJSON( data[i] );

					list.push(debt);
				}

				onResult(list);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
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
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: 'json',
			type: 'POST',
			data: {
				'service':'Debt',
				'action':'updateDebt',
				'debt':{'pid':debt.pid, 'name':debt.name, 'bank':debt.bank, 'balance':debt.balance, 'apr':debt.apr, 'paymentRate':debt.paymentRate, 'active':debt.active},
				'planId':dcd.model.planProxy.selectedPlan.pid
			},
			success: function(data, textStatus, jqXHR)
			{
				onResult(debt);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};
};

dcd.services.debtService = new DebtService();