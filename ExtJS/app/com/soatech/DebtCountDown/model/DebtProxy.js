Ext.namespace('DebtCountDown.model');
DebtCountDown.model.DebtProxy = Ext.extend(Puremvc.patterns.Proxy, 
{
	debtList: null,
	selectedDebt: null,
	
	constructor: function()
	{
		DebtCountDown.model.DebtProxy.superclass.constructor.call(this, DebtCountDown.model.DebtProxy.NAME, null);
	},
	
	addDebt: function(debt /* DebtVO */)
	{
		if( !this.debtList )
			this.debtList = [];
			
		this.debtList.push(debt);
		
		this.sendNotification(DebtCountDown.model.DebtProxy.LIST_CHANGED, this.debtList);
	},
	
	removeDebt: function(debt /* DebtVO */)
	{
		if( !this.debtList )
			return;
			
		for( i = 0; i < this.debtList.length; i++ )
		{
			if( this.debtList[i].pid == debt.pid )
				this.debtList.splice(i, 1);
		}
		
		this.sendNotification(DebtCountDown.model.DebtProxy.LIST_CHANGED, this.debtList);
	},
	
	replaceDebt: function(debt /* DebtVO */)
	{
		if( !this.debtList )
			return;
			
		for( i = 0; i < this.debtList.length; i++ )
		{
			if( this.debtList[i].pid == debt.pid )
				this.debtList[i] = debt;
		}
		
		this.sendNotification(DebtCountDown.model.DebtProxy.LIST_CHANGED, this.debtList);
	}
});

Ext.apply(DebtCountDown.model.DebtProxy, {
	NAME: "DebtProxy",
	
	LIST_CHANGED: "DEBT_PROXY_LIST_CHANGED",
});