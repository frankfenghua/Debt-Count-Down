Ext.define('DCD.model.Plan', {
	extend: 'Ext.data.Model',
	config: {
		idProperty: 'pid',
		fields: [
			{ name: 'pid', type: 'string' },
			{ name: 'name', type: 'string' }
		],
		proxy: {
			type: 'ajax',
			api: {
				create: 'server/dcd_server.php?service=Plan&action=addPlan',
				read: 'server/dcd_server.php?service=Plan&action=loadAllPlans',
				update: 'server/dcd_server.php?service=Plan&action=updatePlan',
				destroy: 'server/dcd_server.php?service=Plan&action=deletePlan',
			},
			reader: 'json',
			autoLoad: true
		}
	}
});