App.views.ManagePlans = Ext.extend(Ext.Panel, {
    initComponent: function(){
        var addButton, titlebar, list;

        addButton = {
            itemId: 'addButton',
            iconCls: 'add',
            iconMask: true,
            ui: 'plain',
            handler: this.onAddAction,
            scope: this
        };

        titlebar = {
            dock: 'top',
            xtype: 'toolbar',
            title: 'Plans',
            items: [ { xtype: 'spacer' }, addButton ]
        };

        list = {
            xtype: 'list',
            itemTpl: '{name}',
            store: App.stores.plans,
			listeners: {
				scope: this,
				itemtap: this.onItemtapAction
			}
        };

        Ext.apply(this, {
            html: 'placeholder',
            layout: 'fit',
            dockedItems: [titlebar],
            items: [list]
        });

        App.views.ManagePlans.superclass.initComponent.call(this);
    },

    onAddAction: function() {
		Ext.dispatch({
			controller: 'Plans',
			action: 'newPlan'
		});
    },
	
	onItemtapAction: function(list, index, item, e) {
		Ext.dispatch({
			controller: 'Plans',
			action: 'editPlan',
			index: index	
		});
	}

});

Ext.reg('App.views.ManagePlans', App.views.ManagePlans);