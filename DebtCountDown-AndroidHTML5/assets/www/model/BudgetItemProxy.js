var dcd = dcd || {};
dcd.model = dcd.model || {};

function BudgetItemProxy()
{
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------

	this.budgetItems = [];

	this.selectedItem = null;

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param item
	 */
	this.addItem = function(item)
	{
		if( !this.budgetItems )
		{
			this.budgetItems = [];
		}

		this.budgetItems.push(item);
	};

	/**
	 * @returns array
	 */
	this.getExpenses = function()
	{
		var list = [];

		for( var i = 0; i < this.budgetItems.length; i++ )
		{
			if( this.budgetItems[i].type == dcd.enum.budgetItemTypes.expense )
			{
				list.push(this.budgetItems[i]);
			}
		}

		return list;
	};

	/**
	 * @returns array
	 */
	this.getIncomes = function()
	{
		var list = [];

		for( var i = 0; i < this.budgetItems.length; i++ )
		{
			if( this.budgetItems[i].type == dcd.enum.budgetItemTypes.income )
			{
				list.push(this.budgetItems[i]);
			}
		}

		return list;
	};

	/**
	 * @param itemId
	 * @returns BudgetItemVO
	 */
	this.getItemById = function(itemId)
	{
		return this.budgetItems[this.getItemIndex(itemId)];
	};

	/**
	 * @param itemId
	 * @returns integer
	 */
	this.getItemIndex = function(itemId)
	{
		for( var i = 0; i < this.budgetItems.length; i++ )
		{
			if( this.budgetItems[i].pid == itemId )
			{
				return i;
			}
		}

		return -1;
	}

	/**
	 * @param item
	 */
	this.removeItem = function(item)
	{
		this.budgetItems.splice(this.getItemIndex(item.pid), 1);
	};

	/**
	 * @param BudgetItemVO
	 */
	this.updateItem = function(item)
	{
		this.budgetItems[this.getItemIndex(item.pid)] = item;
	};

};

dcd.model.budgetItemProxy = dcd.model.budgetItemProxy || new BudgetItemProxy();