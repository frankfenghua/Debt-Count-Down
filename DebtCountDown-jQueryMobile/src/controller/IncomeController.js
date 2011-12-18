var dcd = dcd || {};
dcd.controller = dcd.controller || {};

function IncomeController()
{
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param {BudgetItemVO} item
	 */
	this.addIncome = function(item)
	{
		dcd.services.budgetItemService.addItem(item, this.addItem_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.deleteIncome = function(item)
	{
		dcd.services.budgetItemService.deleteItem(item, this.deleteItem_resultHandler,
			this.faultHandler);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.editIncome = function(item)
	{
		dcd.services.budgetItemService.updateItem(item, this.updateItem_resultHandler,
			this.faultHandler);
	};

	/**
	 *
	 */
	this.loadAllIncomes = function()
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
			this.editIncome(item);
		}
		else
		{
			this.addIncome(item);
		}
	};

	/**
	 * @param {integer} itemId
	 */
	this.showItem = function(itemId)
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

		dcd.services.budgetItemService.updateItem(item, 
			this.updateActive_resultHandler, this.faultHandler);
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

		dcd.controller.appController.changePage(dcd.enum.pages.manageIncomes);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.deleteItem_resultHandler = function(item)
	{
		dcd.model.budgetItemProxy.removeItem(item);
		dcd.model.budgetItemProxy.selectedItem = null;

		dcd.controller.appController.changePage(dcd.enum.pages.manageIncomes);
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
			if( items[i].type != dcd.enum.budgetItemTypes.income )
			{
				continue;
			}

			if( items[i].active )
			{
				theme = "b";
			}

			list += '<li><a href="#" class="edit-income-link" value="'
				+ items[i].pid + '">' + items[i].name + '</a><a href="#" '
				+ 'class="check-income-link" data-theme="' + theme + '" value="'
				+ items[i].pid + '"></a></li>';
		}

		dcd.view.manageIncomesMediator.reloadIncomes(list);
	};

	/**
	 * @param {BudgetItemVO} item
	 */
	this.loadItem_resultHandler = function(item)
	{
		dcd.model.budgetItemProxy.selectedItem = item;

		dcd.controller.appController.changePage(dcd.enum.pages.editIncome);
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

		dcd.controller.appController.changePage(dcd.enum.pages.manageIncomes);
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

dcd.controller.incomeController = new IncomeController();