Ext.define('DCD.store.Plans', {
	extend: 'Ext.data.Store',
	alias: 'store.Plans',
	config: {
		model: 'DCD.model.Plan',
	
		proxy: {
			type: 'ajax',
			api: {
				create: 'server/dcd_server.php?service=Plan&action=addPlan',
				read: 'server/dcd_server.php?service=Plan&action=loadAllPlans',
				update: 'server/dcd_server.php?service=Plan&action=updatePlan',
				destroy: 'server/dcd_server.php?service=Plan&action=deletePlan',
			},
			reader: 'json'
		},
		autoLoad: true
	}
});