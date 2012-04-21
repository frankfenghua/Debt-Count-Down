Ext.define('DCD.store.Plans', {
	storeId: 'PlanStore',
	extend: 'Ext.data.proxy.Ajax',
	model: 'DCD.model.Plan',
	requires: ['DCD.model.Plan'],
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
});