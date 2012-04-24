Ext.define('DCD.controller.PlanEdit', {
	extend: 'Ext.app.Controller',

	views: ['PlanEdit'],

	config: {
		refs: {
			saveBtn: {
				xtype: 'button',
				selector: 'button[name=plan-save-btn]'
			},
			deleteBtn: {
				xtype: 'button',
				selector: 'button[name=plan-delete-btn]'
			},
			continueBtn: {
				xtype: 'button',
				selector: 'button[name=plan-cont-bnt]'
			},
			name: {
				xtype: 'textfield',
				selector: 'fieldset[name=plan-form] textfield[name=name]'
			},
			pid: {
				xtype: 'hidden',
				selector: 'fieldset[name=plan-form] hiddenfield[name=pid]'
			}

		},
		control: {
			saveBtn: {
				tap: 'onSaveBtnTap'
			},
			deleteBtn: {
				tap: 'onDeleteBtnTap'
			},
			continueBtn: {
				tap: 'onContinueBtnTap'
			}
		}
	},

	onContinueBtnTap: function() {
		// save and move onto next screen
	},

	onDeleteBtnTap: function() {
		// remove record and go back to Manage Plans
	},

	onSaveBtnTap: function() {
		var savePlan = Ext.create('DCD.model.Plan', {name: this.getName(), pid: this.getPid()});
		
		savePlan.save(this.onSaveSuccess, this);
	},

	onSaveSuccess: function(a, b, c) {

	}
});