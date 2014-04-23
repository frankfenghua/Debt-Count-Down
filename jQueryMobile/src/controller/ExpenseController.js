var dcd = dcd || {};
dcd.controller = dcd.controller || {};

function ExpenseController()
{
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param {BudgetItemVO} item
	 */
	this.addExpense = function(item)
	{
		dcd.services.budgetItemService.addItem(item, this.addItem_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.deleteExpense = function(item)
	{
		dcd.services.budgetItemService.deleteItem(item, this.deleteItem_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.editExpense = function(item)
	{
		dcd.services.budgetItemService.updateItem(item, this.updateItem_resultHandler,
			this.faultHandler);
	};

	/**
	 *
	 */
	this.loadAllExpenses = function()
	{
		dcd.services.budgetItemService.loadAllItems(this.loadAllItems_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.save = function(item)
	{
		if( item.pid )
		{
			this.editExpense(item);
		}
		else
		{
			this.addExpense(item);
		}
	};

	/**
	 * @param {integer} itemId
	 */
	this.showExpense = function(itemId)
	{
		dcd.services.budgetItemService.loadItem(itemId, this.loadItem_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param {integer} itemId
	 * @param {boolean} active
	 */
	this.updateActive = function(itemId, active)
	{
		var item = dcd.model.budgetItemProxy.getItemById(itemId);
		item.active = active;

		dcd.services.budgetItemService.updateItem(item, this.updateActive_resultHandler,
			this.faultHandler);
	};

	//-------------------------------------------------------------------------
	//
	// Result Handlers
	//
	//-------------------------------------------------------------------------

	/**
	 * @param {BudgetItemVO} item
	 */
	this.addItem_resultHandler = function(item)
	{
		dcd.model.budgetItemProxy.addItem(item);
		dcd.model.budgetItemProxy.selectedItem = null;

		dcd.controller.appController.changePage(dcd.enum.pages.manageExpenses, {"reverse":true});
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.deleteItem_resultHandler = function(item)
	{
		dcd.model.budgetItemProxy.removeItem(item);
		dcd.model.budgetItemProxy.selectedItem = null;

		dcd.controller.appController.changePage(dcd.enum.pages.manageExpenses, {"reverse":true});
	};

	/**
	 * @param {Array} items
	 */
	this.loadAllItems_resultHandler = function(items)
	{
		dcd.model.budgetItemProxy.budgetItems = items;

		var list = "";
		var theme = "c";

		for( var i = 0; i < items.length; i++ )
		{
			if( items[i].type != dcd.enum.budgetItemTypes.expense )
			{
				continue;
			}

			if( items[i].active )
			{
				theme = "b";
			}

			list += '<li><a href="#" class="edit-expense-link" value="'
				+ items[i].pid + '">' + items[i].name + '</a><a href="#" '
				+ 'class="check-expense-link" data-theme="' + theme + '" value="'
				+ items[i].pid + '"></a></li>';
		}

		dcd.view.manageExpensesMediator.reloadExpenses(list);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.loadItem_resultHandler = function(item)
	{
		dcd.model.budgetItemProxy.selectedItem = item;

		dcd.controller.appController.changePage(dcd.enum.pages.editExpense);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.updateActive_resultHandler = function(item)
	{
		dcd.model.budgetItemProxy.updateItem(item);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.updateItem_resultHandler = function(item)
	{
		dcd.model.budgetItemProxy.updateItem(item);
		dcd.model.budgetItemProxy.selectedItem = null;

		dcd.controller.appController.changePage(dcd.enum.pages.manageExpenses, {"reverse":true});
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

dcd.controller.expenseController = new ExpenseController();