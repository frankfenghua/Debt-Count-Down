Ext.namespace('DebtCountDown.model');
DebtCountDown.model.StatsProxy = Ext.extend(Puremvc.patterns.Proxy, 
{
	balanceStats: null, /* StatsVO */
	rateStats: null, /* StatsVO */
	minStats: null, /* StatsVO */
	selectedRoutine: null, /* string */
	
	constructor: function()
	{
		DebtCountDown.model.StatsProxy.superclass.constructor.call(this, DebtCountDown.model.StatsProxy.NAME, null);
	}
});

Ext.apply(DebtCountDown.model.StatsProxy, {
	NAME: "StatsProxy"
});