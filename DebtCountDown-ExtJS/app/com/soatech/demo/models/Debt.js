App.models.Debt = Ext.regModel('Debt', {
    fields: [
        {
            name: 'id',
            type: 'int'
        }, {
            name: 'name',
            type: 'string'
        }
    ],

    proxy: {
        type: 'localstorage',
        id: 'dcd-debts'
    }
});