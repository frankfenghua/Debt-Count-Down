Ext.define('DCD.view.ManagePlans', {
	extend: 'Ext.NavigationView',
	id: 'plan-list',

	config: {
		fullscreen: true,
		navigationBar: {
			items: [
				{
					xtype: 'button',
					text: 'Add',
					align: 'right',
					id: 'plan-add-btn'
				}
			]
		},
		items: [
			{
				title: 'Plans',
				layout: 'fit',
				items: [
					{
						title: 'Plans',
						width: '100%',
						height: '100%',
						xtype: 'list',
						ui: 'round',
						grouped: false,
						pinHeaders: false,
						itemTpl: '{name}',
						store: 'Plans'
					}
				]

			}

		]
	},

	// initialize: function () {
	// 	this.getNavigationBar().add({
	// 		xtype: 'button',
	// 		label: 'Add',
	// 		title: 'Add'
	// 	})
	// }

});