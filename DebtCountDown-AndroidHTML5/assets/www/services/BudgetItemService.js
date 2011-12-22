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
		item.pid = dcd.model.budgetItemProxy.budgetItems.length+1;
		onResult(item);
	};

	/**
	 * @param {BudgetItemVO} item
	 * @param {Function} onResult
	 * @param {Function} onFault
	 */
	this.deleteItem = function(item, onResult, onFault)
	{
		onResult(item);
	};

	/**
	 * @param {Function} onResult
	 * @param {Function} onFault
	 */
	this.loadAllItems = function(onResult, onFault)
	{
		var list = [];
		var json = '';
		var item = null;

		if( !dcd.model.budgetItemProxy.budgetItems.length )
		{
			json = jQuery.parseJSON('{"budgetItems":[{"pid":"1", "active":"false", "amount":"123.45", "name":"Expense 1", "type":"EXPENSE"}, {"active":"false", "amount":"6543.21", "name":"Income 1", "pid":"2", "type":"INCOME"}]}');
			
			for( var i = 0; i < json.budgetItems.length; i++ )
			{
				item = new BudgetItemVO();
				item.fromJSON( json.budgetItems[i] );

				list.push(item);
			}
		}
		else
		{
			list = dcd.model.budgetItemProxy.budgetItems;
		}

		onResult(list);
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
		onResult(item);
	};
};

dcd.services.budgetItemService = new BudgetItemService();