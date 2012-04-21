Ext.define('DCD.controller.ManagePlans', {
	extend: 'Ext.app.Controller',

	views: ['ManagePlans'],

	refs: [
		{
			ref: 'plan-list',
			selector: 'plan-list'
		}
	],

	init: function() {
		this.callParent(arguments);

		console.log('ManagePlans Controller');
		this.control({
			'#plan-list': {
				show: this.onShowList,
				select: this.onListSelect
			},

			'#plan-add-btn': {
				tap: this.onAddBtnTap
			}
		});

	},

	launch: function() {
		this.callParent(arguments);

		console.log(Ext.getStore('Plans'));
	},

	onShowList: function() {
		this.loadData();
	},

	onListSelect: function() {

	},

	onAddBtnTap: function() {
		console.log('adding');
	},

	loadData: function() {
		
	}

});