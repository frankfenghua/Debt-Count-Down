Ext.namespace('DebtCountDown.model');
DebtCountDown.model.PlanProxy = Ext.extend(Puremvc.patterns.Proxy, 
{
	planList: null,
	selectedPlan: null,
	
	constructor: function()
	{
		DebtCountDown.model.PlanProxy.superclass.constructor.call(this, DebtCountDown.model.PlanProxy.NAME, null);
	},
	
	addPlan: function(plan /* PlanVO */)
	{
		if( !this.planList )
			this.planList = [];
			
		this.planList.push(plan);
		
		this.sendNotification(DebtCountDown.model.PlanProxy.LIST_CHANGED, this.planList);
	},
	
	removePlan: function(plan /* PlanVO */)
	{
		if( !this.planList )
			return;
			
		for( i = 0; i < this.planList.length; i++ )
		{
			if( this.planList[i].pid == plan.pid )
				this.planList.splice(i, 1);
		}
		
		this.sendNotification(DebtCountDown.model.PlanProxy.LIST_CHANGED, this.planList);
	},
	
	replacePlan: function(plan /* PlanVO */)
	{
		if( !this.planList )
			return;
			
		for( i = 0; i < this.planList.length; i++ )
		{
			if( this.planList[i].pid == plan.pid )
				this.planList[i] = plan;
		}
		
		this.sendNotification(DebtCountDown.model.PlanProxy.LIST_CHANGED, this.planList);
	}
});

Ext.apply(DebtCountDown.model.PlanProxy, {
	NAME: "PlanProxy",
	
	LIST_CHANGED: "PLAN_PROXY_LIST_CHANGED",
});