Ext.namespace('DebtCountDown');
DebtCountDown.ApplicationFacade = Ext.extend(Puremvc.patterns.Facade, {
	
	constructor: function() {
		DebtCountDown.ApplicationFacade.superclass.constructor.call(this);
	},
	
	initializeController: function() {
		DebtCountDown.ApplicationFacade.superclass.initializeController.call(this);
//		this.registerCommand(DebtCountDown.ApplicationFacade.STARTUP, DebtCountDown.controller.StartupCommand);
	},
	
	startup: function(viewComponent) {
		this.sendNotification(DebtCountDown.ApplicationFacade.STARTUP, viewComponent);
	}
});

Ext.apply(DebtCountDown.ApplicationFacade, {
	STARTUP: "Startup",
	_instance: null
});

Ext.apply(DebtCountDown.ApplicationFacade, {
	
	getInstance: function() {
		if( DebtCountDown.ApplicationFacade._instance === null ) {
			DebtCountDown.ApplicationFacade._instance = new DebtCountDown.ApplicationFacade();
		}
		return DebtCountDown.ApplicationFacade._instance;
	}
});