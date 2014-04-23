App.views.ManageDebts = Ext.extend(Ext.Panel, {
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
            title: 'Debts',
            items: [ { xtype: 'spacer' }, addButton ]
        };

        list = {
            xtype: 'list',
            itemTpl: '{name}',
            store: App.stores.debts
        };

        Ext.apply(this, {
            html: 'placeholder',
            layout: 'fit',
            dockedItems: [titlebar],
            items: [list]
        });

        App.views.ManageDebts.superclass.initComponent.call(this);
    },

    onAddAction: function() {
       
    }

});

Ext.reg('App.views.ManageDebts', App.views.ManageDebts);