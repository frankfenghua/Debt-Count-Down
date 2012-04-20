Ext.create('Ext.data.Store', {
	id: 'PlanStore',
	model: 'DCD.model.Plan',
	proxy: {
		type: 'ajax',
		url: 'server/dcd_server.php?service=Plan&action=loadAllPlans',
		reader: 'json'
	},
	autoLoad: true
});

Ext.define('DCD.view.ManagePlans', {
	extend: 'Ext.NavigationView',

	config: {
		fullscreen: true,
		items: [
			{
				xtype: 'button',
			    text: 'Add',
			    align: 'right'
			},
			{
				title: 'Plans',
				layout: {
					type: 'vbox',
					pack: 'center',
					align: 'center'
				},
				items: [
					{
						title: 'Plans',
						minWidth: 300,
						minHeight: 300,
						width: '100%',
						height: '100%',
						xtype: 'list',
						ui: 'round',
						grouped: false,
						pinHeaders: false,
						itemTpl: '{name}',
						store: 'PlanStore'
					}
				]

			}

		]
	}

});