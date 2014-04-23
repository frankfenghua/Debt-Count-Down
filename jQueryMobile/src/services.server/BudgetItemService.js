var dcd = dcd || {};
dcd.services = dcd.services || {};

function BudgetItemService()
{
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param {BudgetItemVO} item
	 * @param {Function} onResult
	 * @param {Function} onFault
	 */
	this.addItem = function(item, onResult, onFault)
	{
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: 'json',
			type: 'POST',
			data: {
				'service':'BudgetItem',
				'action':'addItem',
				'item':{'name':item.name, 'amount':item.amount, 'type':item.type, 'active':item.active},
				'planId':dcd.model.planProxy.selectedPlan.pid
			},
			success: function(data, textStatus, jqXHR)
			{
				item.pid = data.pid;
				onResult(item);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};

	/**
	 * @param {BudgetItemVO} item
	 * @param {Function} onResult
	 * @param {Function} onFault
	 */
	this.deleteItem = function(item, onResult, onFault)
	{
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: 'json',
			type: 'POST',
			data: {
				'service':'BudgetItem',
				'action':'deleteItem',
				'pid':item.pid,
				'planId':dcd.model.planProxy.selectedPlan.pid
			},
			success: function(data, textStatus, jqXHR)
			{
				onResult(item);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};

	/**
	 * @param {Function} onResult
	 * @param {Function} onFault
	 */
	this.loadAllItems = function(onResult, onFault)
	{
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: 'json',
			data: {
				'service':'BudgetItem',
				'action':'loadAllItems',
				'planId':dcd.model.planProxy.selectedPlan.pid
			},
			success: function(data, textStatus, jqXHR)
			{
				var item;
				var list = new Array();

				for( var i = 0; i < data.length; i++ )
				{
					item = new BudgetItemVO();
					item.fromJSON( data[i] );

					list.push(item);
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
	 * @param {integer} itemId
	 * @param {Function} onResult
	 * @param {Function} onFault
	 */
	this.loadItem = function(itemId, onResult, onFault)
	{
		var item = dcd.model.budgetItemProxy.getItemById(itemId);

		onResult(item);
	};

	/**
	 * @param {BudgetItemVO} item
	 * @param {Function} onResult
	 * @param {Function} onFault
	 */
	this.updateItem = function(item, onResult, onFault)
	{
		$.ajax({
			url: 'server/dcd_server.php',
			dataType: 'json',
			type: 'POST',
			data: {
				'service':'BudgetItem',
				'action':'updateItem',
				'item':{'pid':item.pid, 'name':item.name, 'amount':item.amount, 'type':item.type, 'active':item.active},
				'planId':dcd.model.planProxy.selectedPlan.pid
			},
			success: function(data, textStatus, jqXHR)
			{
				onResult(item);
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				onFault(errorThrown);
			}
		});
	};
};

dcd.services.budgetItemService = new BudgetItemService();