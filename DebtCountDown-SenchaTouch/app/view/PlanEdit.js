Ext.define('DCD.view.PlanEdit', {
	extend: 'Ext.form.Panel',

	config: {
		fullscreen: true,
		layout: 'vbox',
		width: '100%',
		height: '100%',

		items: [
			{
				xtype: 'fieldset',
				name: 'plan-form',
				instructions: 'Name your Plan so you can quickly reference it again later.',
				defaults: {
					labelWidth: '35%'
				},
				items: [
					{
						xtype: 'hiddenfield',
						name: 'pid'
					},
					{
						xtype: 'textfield',
						name: 'name',
						label: 'Name',
						placeHolder: 'My Plan',
						required: true,
						clearIcon: true
					}
				]
			},
			{
				xtype: 'panel',
				layout: 'vbox',
				items: [
					{
						xtype: 'button',
						width: '100%',
						text: 'Delete Plan',
						name: 'plan-delete-btn'
					},
					{
						xtype: 'spacer',
						height: 10
					},
					{
						xtype: 'button',
						width: '100%',
						text: 'Continue',
						name: 'plan-cont-btn'
					}
				]
			}
		]
	},

	plan: null,

	getRightButton: function() {
		return {
			xtype: 'button',
			text: 'Save',
			align: 'right',
			id: 'plan-save-btn',
			name: 'plan-save-btn'
		};
	},

	show: function() {
		// populate the view with plan data

		if( this.plan )
		{
			this.setValues({
				name: this.plan.name,
				pid: this.plan.pid
			});
		}
		else // otherwise clear the form
		{
			this.setValues({
				name: null
			});
		}

		this.callParent(arguments);
	}
});