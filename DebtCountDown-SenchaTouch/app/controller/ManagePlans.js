Ext.define('DCD.controller.ManagePlans', {
	extend: 'Ext.app.Controller',

	views: ['ManagePlans'],
	
	config: {
		// routes: {
		// 	'plans': 'listPlans',
		// 	'plans/add': 'addPlan',
		// 	'plans/edit/:id': 'editPlan'
		// }
	},

	init: function() {
		this.callParent(arguments);

		console.log('ManagePlans Controller::init');
		
	},

	launch: function() {
		console.log('ManagePlansController::launch');
		this.callParent(arguments);

		this.setListeners();
	},

	setListeners: function() {
		this.control({
			'#plan-list': {
				select: 'onListSelect'
			},
			'#plan-add-btn': {
				tap: 'onAddBtnTap'
			}
		});
	},

	onListSelect: function(view, record, eOpts) {
		// Ext.ComponentManager.get('Navigator').push(Ext.create('DCD.view.PlanEdit', {plan: record.data}));
		
		var planEdit = Ext.create('DCD.view.PlanEdit');
		planEdit.plan = record.data;
		Ext.ComponentManager.get('Navigator').push(planEdit);

		this.setListeners();
	},

	onAddBtnTap: function() {
		
		var planEdit = Ext.create('DCD.view.PlanEdit');
		planEdit.plan = null;
		Ext.ComponentManager.get('Navigator').push(planEdit);

		this.setListeners();
	}

});