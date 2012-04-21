Ext.define('DCD.controller.Navigator', {
	extend: 'Ext.app.Controller',

	views: ['Navigator'],

	routes: {
		'#plan-edit': 'showPlanEdit'
	},

	refs: {
		navigator: 'Navigator'
	},

	init: function() {
		this.callParent(arguments);

		this.control({
			
		});
	}
});