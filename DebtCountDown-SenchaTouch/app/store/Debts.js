Ext.define('DCD.store.Debts', {
	extend: 'Ext.data.Store',
	alias: 'store.Debts',
	requires: ['DCD.model.Debt'],
	
	config: {
		model: 'DCD.model.Debt',
		autoLoad: false,
		proxy: {
			type: 'ajax',
			api: {
				create: 'server/dcd_server.php?service=Debt&action=addDebt',
				read: 'server/dcd_server.php?service=Debt&action=loadAllDebts',
				update: 'server/dcd_server.php?service=Debt&action=updateDebt',
				destroy: 'server/dcd_server.php?service=Debt&action=deleteDebt',
			},
			reader: 'json',
			autoLoad: false
		}
	}
});