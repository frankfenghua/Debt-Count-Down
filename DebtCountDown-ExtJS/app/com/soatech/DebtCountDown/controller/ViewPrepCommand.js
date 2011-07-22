Ext.namespace('DebtCountDown.controller');
DebtCountDown.controller.ViewPrepCommand = Ext.extend(Puremvc.patterns.SimpleCommand, {
	constructor: function()
	{
		DebtCountDown.controller.ViewPrepCommand.superclass.constructor.call(this);
	},
	
	execute: function(notification)
	{
		var manage = notification.getBody();
		
		this.facade.registerMediator(new DebtCountDown.view.ManageMediator(manage));
	}
});