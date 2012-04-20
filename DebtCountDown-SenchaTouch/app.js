Ext.application({
    name: 'DCD',
    models: ['Plan'],
    views: ['ManagePlans'],
    

    launch: function() {
        Ext.create('DCD.view.ManagePlans');
    }
});