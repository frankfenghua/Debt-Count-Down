Ext.define('DCD.view.ManageDebts',{
	extend: 'Ext.Panel',
	id: 'manage-debts-view',
	name: 'manage-debts-view',

	plan: null,

	config: {
		fullscreen: true,
		layout: 'fit',
		title: 'Debts',
		items: [
			{
				xtype: 'list',
				id: 'debt-list',
				name: 'debt-list',
				width: '100%',
				height: '100%',
				ui: 'round',
				grouped: false,
				pinHeaders: false,
				store: 'Debts',
				itemTpl: '<div class="debt-list-name">{name}</div><div class="debt-list-active {active}"></div>',
				// itemTpl: '<div class="debt-list-name">{name}</div>',
				// itemCls: 'active-{active}',
				onItemDisclosure: false,
				preventSelectionOnDisclose: false
			}
		]
	},

	getRightButton: function() {
		return {
			xtype: 'button',
			text: 'Add',
			align: 'right',
			id: 'debt-add-btn',
			itemId: 'debt-add-btn',
			name: 'debt-add-btn'
		};
	}
});