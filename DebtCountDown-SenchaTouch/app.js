Ext.application({
    name: 'DCD',
    models: ['Plan'],
    views: ['Navigator', 'ManagePlans', 'PlanEdit', 'ManageDebts'],
    controllers: ['Navigator', 'ManagePlans', 'PlanEdit', 'ManageDebts'],
    stores: ['Plans', 'Debts'],

    launch: function() {
        Ext.create('DCD.view.Navigator');
        Ext.ComponentManager.get('Navigator').push(Ext.create('DCD.view.ManagePlans'));
    }
});