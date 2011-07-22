Ext.namespace('DebtCountDown.controller');
DebtCountDown.controller.ModelPrepCommand = Ext.extend(Puremvc.patterns.SimpleCommand, {
	constructor: function()
	{
		DebtCountDown.controller.ModelPrepCommand.superclass.constructor.call(this);
	},
	
	execute: function(notification)
	{
		this.facade.registerProxy(new DebtCountDown.model.DebtProxy());
		this.facade.registerProxy(new DebtCountDown.model.PlanProxy());
	}
});