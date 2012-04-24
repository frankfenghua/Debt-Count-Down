Ext.application({
    name: 'DCD',
    models: ['Plan'],
    views: ['Navigator', 'ManagePlans', 'PlanEdit'],
    controllers: ['Navigator', 'ManagePlans', 'PlanEdit'],
    stores: ['Plans'],

    launch: function() {
    	// var container = Ext.create('Ext.NavigationView', {
     //    	id: 'DCD-Wrapper',
     //    	initialize: function() {
	    //     	this.getNavigationBar().hide();
	    //     },
	    //     activate: function() {
	    //     	this.getNavigationBar().hide();
	    //     }
     //    });
     //    container.getNavigationBar().hide();
     //    Ext.Viewport.add(container);

     //    // Ext.ComponentManager.get('DCD-Wrapper').push(Ext.create('DCD.view.ManagePlans'));
     //    container.push(Ext.create('DCD.view.ManagePlans'));

        Ext.create('DCD.view.Navigator');
        Ext.ComponentManager.get('Navigator').push(Ext.create('DCD.view.ManagePlans'));
    }
});