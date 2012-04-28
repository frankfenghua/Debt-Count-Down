Ext.define('DCD.controller.ManageDebts', {
	extend: 'Ext.app.Controller',

	views: ['ManageDebts'],

	config: {
		control: {
			debtList: {
				select: 'onListSelect'
			},
			debtAddBtn: {
				tap: 'onAddBtnTap'
			},
			view: {
				show: 'onViewShow'
			},
			debtActiveBtn: {
				tap: 'onActiveBtnTap'
			}
		},

		refs: {
			debtAddBtn: {
				xtype: 'button',
				selector: 'button[name=debt-add-btn]'
			},
			debtList: {
				xtype: 'list',
				selector: 'panel[name=manage-debts-view] list[name=debt-list]'
			},
			view: {
				xtype: 'panel',
				selector: 'panel[name=manage-debts-view]'
			},
			debtActiveBtn: '.debt-list-active'
		}
	},

	onActiveBtnTap: function() {
		console.log('onActiveBtnTap');
	},

	onViewShow: function() {
		var plan = this.getView().plan;

		if( plan ) {
			var debtStore = Ext.getStore('Debts');

			debtStore.load({
				params: {planId: plan.get('pid')}
			});
		}

	},

	onListSelect: function(view, record, eOpts) {
		console.log('onListSelect');
		return;
		var debtEdit = Ext.create('DCD.view.DebtEdit');
		debtEdit.plan = record.data;
		Ext.ComponentManager.get('Navigator').push(debtEdit);
	},

	onAddBtnTap: function() {
		console.log("ManagePlansController::onAddBtnTap");
		return;

		var debtEdit = Ext.create('DCD.view.DebtEdit');
		debtEdit.plan = null;
		Ext.ComponentManager.get('Navigator').push(debtEdit);
	}

});