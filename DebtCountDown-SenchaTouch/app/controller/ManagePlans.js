Ext.define('DCD.controller.ManagePlans', {
	extend: 'Ext.app.Controller',

	views: ['ManagePlans'],
	
	config: {
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

	onListSelect: function(view, record, eOpts) {
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