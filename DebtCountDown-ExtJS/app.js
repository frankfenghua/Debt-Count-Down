Ext.application({
	name: 'DebtCountDown',
	launch: function() {
		Ext.create('Ext.container.Viewport', {
			layout: 'fit',
			items: [
				{
					title: 'Debt Count Down',
					html: 'Hello! Welcome to Debt count Down.'
				}
			]
		});
	}
});