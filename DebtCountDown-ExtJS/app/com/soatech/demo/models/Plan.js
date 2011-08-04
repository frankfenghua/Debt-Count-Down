App.models.Plan = Ext.regModel('Plan', {
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
        id: 'dcd-plans'
    }
});