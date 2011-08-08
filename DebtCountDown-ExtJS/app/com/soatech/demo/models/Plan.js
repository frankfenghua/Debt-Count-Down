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

    proxy: {
        type: 'localstorage',
        id: 'dcd-plans'
    }
});