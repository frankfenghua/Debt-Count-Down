Ext.define('DCD.store.Plans', {
	extend: 'Ext.data.Store',
	alias: 'store.Plans',
	requires: ['DCD.model.Plan'],
	
	config: {
		model: 'DCD.model.Plan',
		autoLoad: true
	}
});