Ext.define('DCD.controller.Navigator', {
	extend: 'Ext.app.Controller',

	views: ['Navigator'],

	config: {
		control: {
			'#plan-add-btn': {
				tap: 'onAddBtnTap'
			}
		}
	},
		
	init: function() {
		this.callParent(arguments);
	},

	onAddBtnTap: function() {
		
		var planEdit = Ext.create('DCD.view.PlanEdit');
		planEdit.plan = null;
		Ext.ComponentManager.get('Navigator').push(planEdit);
	}
});