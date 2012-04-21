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
				title: 'Plan Edit',
				instructions: 'Name your Plan so you can quickly reference it again later.',
				defaults: {
					labelWidth: '35%'
				},
				items: [
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
				defaults: {
					xtype: 'button',
					width: '100%'
				},
				layout: {
					type: 'vbox'
				},
				items: [
					{
						text: 'Delete Plan'
					},
					{
						text: 'Continue'
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
			id: 'plan-save-btn'
		};
	},

	show: function() {
		// populate the view with plan data

		if( this.plan )
		{
			this.setValues({
				name: this.plan.name
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