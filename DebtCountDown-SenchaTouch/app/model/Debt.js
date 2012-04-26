Ext.define('DCD.model.Debt', {
	extend: 'Ext.data.Model',
	config: {
		idProperty: 'pid',
		fields: [
			{ name: 'pid', type: 'string' },
			{ name: 'active', type: 'boolean' },
			{ name: 'apr', type: 'float' },
			{ name: 'balance', type: 'float' },
			{ name: 'bank', type: 'string' },
			{ name: 'name', type: 'string' },
			{ name: 'paymentRate', type: 'float' },
			{ name: 'plans', type: 'auto' }

		],
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
	},

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @returns float
	 */
	estimateMinPayment: function()
	{
		var retval = 0.0;
		var rate = 0.0;
		
		// 3% is the highest I've seen
		rate = 3 / 100;
		
		retval = Math.floor(this.balance * rate);
		
		return retval;
	},

	/**
	 * @return float
	 */
	getMinPayment: function()
	{
		var min = this.balance * this.paymentRate;
			
		// make no payment less than $15
		if( min < 15 )
			min = 15;
		
		return min;
	}
});