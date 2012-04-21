Ext.application({
    name: 'DCD',
    models: ['Plan'],
    views: ['ManagePlans'],
    controllers: ['ManagePlans'],
    stores: ['Plans'],

    launch: function() {
        Ext.create('DCD.view.ManagePlans');

        console.log('Plans Get: ' + Ext.getStore('PlanStore'));

        console.log(Ext.data.StoreManager);
    }
});