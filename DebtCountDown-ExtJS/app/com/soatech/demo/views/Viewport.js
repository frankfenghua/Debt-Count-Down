App.views.Viewport = Ext.extend(Ext.TabPanel, {
    fullscreen: true,
    layout: 'card',
    
    initComponent: function() {
        Ext.apply(this, {
            items: [
                { xtype: 'App.views.ManagePlans', id: 'managePlans', title: 'Manage Plans' },
                { xtype: 'App.views.ManageDebts', id: 'manageDebts', title: 'Manage Debts' },
            ]
        });
        App.views.Viewport.superclass.initComponent.apply(this, arguments);
    },

    reveal: function(target) {
        var direction = (target === 'managePlans') ? 'right' : 'left'
        this.setActiveItem(
            App.views[target],
            { type: 'slide', direction: direction }
        );
    }
});