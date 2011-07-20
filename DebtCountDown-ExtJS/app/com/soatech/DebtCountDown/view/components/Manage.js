Ext.namespace('DebtCountDown.view.components');
DebtCountDown.view.components.Manage = Ext.extend(DebtCountDown.view.components.core.UIComponent, {
	contructor: function () {
		DebtCountdown.view.components.Manage.superclass.constructor.call(this, "manage", {});
	},
	
	initializeChildren: function() {
		Ext.create('Ext.panel.Panel', {
			renderTo: Ext.getBody(),
			width: 400,
			height: 500,
			title: 'Manage Plans'
		});
	},
	
	childrenInitialize: function() {
		// add listeners after creation
	},
	
	initializationComplete: function() {
		DebtCountDown.view.components.Manage.superclass.initializationComplete.call(this);
	}
});