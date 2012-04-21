Ext.define('DCD.view.ManagePlans', {
	extend: 'Ext.Panel',
	id: 'ManagePlansView',
	
	config: {
		fullscreen: true,
		layout: 'fit',
		title: 'Plans',
		items: [
			{
				id: 'plan-list',
				title: 'Plans',
				width: '100%',
				height: '100%',
				xtype: 'list',
				ui: 'round',
				grouped: false,
				pinHeaders: false,
				itemTpl: '<strong>{name}</strong>',
				store: 'Plans'
			}
		]
	},

	getRightButton: function() {
		return {
			xtype: 'button',
			text: 'Add',
			align: 'right',
			id: 'plan-add-btn'
		};
	}

});