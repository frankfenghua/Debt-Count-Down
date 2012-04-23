Ext.define('DCD.controller.ManagePlans', {
	extend: 'Ext.app.Controller',

	views: ['ManagePlans'],
	
	config: {
		// routes: {
		// 	'plans': 'listPlans',
		// 	'plans/add': 'addPlan',
		// 	'plans/edit/:id': 'editPlan'
		// }

		control: {
			planList: {
				select: 'onListSelect'
			},
			planAddBtn: {
				tap: 'onAddBtnTap'
			}
		},

		refs: {
			planAddBtn: {
				xtype: 'button',
				selector: 'button[name=plan-add-btn]'
			},
			planList: {
				xtype: 'list',
				selector: 'panel[name=manage-plans-view] list[name=plan-list]'
			}
		}
	},

	init: function() {
		this.callParent(arguments);

		console.log('ManagePlans Controller::init');
		
	},

	launch: function() {
		console.log('ManagePlansController::launch');
		this.callParent(arguments);
	},

	onListSelect: function(view, record, eOpts) {
		// Ext.ComponentManager.get('Navigator').push(Ext.create('DCD.view.PlanEdit', {plan: record.data}));
		
		var planEdit = Ext.create('DCD.view.PlanEdit');
		planEdit.plan = record.data;
		Ext.ComponentManager.get('Navigator').push(planEdit);
	},

	onAddBtnTap: function() {
		console.log("ManagePlansController::onAddBtnTap");

		var planEdit = Ext.create('DCD.view.PlanEdit');
		planEdit.plan = null;
		Ext.ComponentManager.get('Navigator').push(planEdit);
	}

});