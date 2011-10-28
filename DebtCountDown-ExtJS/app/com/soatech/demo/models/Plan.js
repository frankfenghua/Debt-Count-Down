App.models.Plan = Ext.regModel('Plan', {
    fields: [
        {
            name: 'id',
            type: 'int'
        }, {
            name: 'name',
            type: 'string'
        }, {
			name: 'expenses',
			type: 'float'
		}, {
			name: 'income',
			type: 'float'
		}
    ],
	
	validations: [
		{
			type: 'presence',
			name: 'name'
		}, {
			type: 'format', name: 'expenses', matcher: /^[0-9]+\.[0-9]{2}$/, message: 'E.g. 12345.67 (no commas, $, or other symbols)'
		}, {
			type: 'format', name: 'income', matcher: /^[0-9]+\.[0-9]{2}$/, message: 'E.g. 12345.67 (no commas, $, or other symbols)'
		}
	],
	
	hasMany: 'Debt',

    proxy: {
        type: 'localstorage',
        id: 'dcd-plans'
    }
});