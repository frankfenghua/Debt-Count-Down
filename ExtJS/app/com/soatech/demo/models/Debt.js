App.models.Debt = Ext.regModel('Debt', {
    fields: [
        {
            name: 'id',
            type: 'int'
        }, 
		{
			name: 'planId',
			type: 'int'
		},
		{
            name: 'name',
            type: 'string'
        },
		{
			name: 'bank',
			type: 'string'
		},
		{
			name: 'balance',
			type: 'float'
		},
		{
			name: 'apr',
			type: 'float'
		},
		{
			name: 'minPayment',
			type: 'float'
		}
    ],
	
	validations: [
		{
			type: 'presence',
			name: 'name'
		}, {
			type: 'format', name: 'balance', matcher: /^[0-9]+\.[0-9]{2}$/, message: 'E.g. 12345.67 (no commas, $, or other symbols)'
		}, {
			type: 'format', name: 'apr', matcher: /^[0-9]+\.[0-9]{2,3}$/, message: 'E.g. 12345.678 (no commas, $, or other symbols)'
		},
		{
			type: 'format', name: 'minPayment', matcher: /^[0-9]+\.[0-9]{2}$/, message: 'E.g. 12345.67 (no commas, $, or other symbols)'
		}
	],
	
	belongsTo: 'Plan',
	
    proxy: {
        type: 'localstorage',
        id: 'dcd-debts'
    }
});