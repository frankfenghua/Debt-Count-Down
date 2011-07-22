Ext.namespace('DebtCountDown.view.components');
DebtCountDown.view.components.Manage = Ext.extend(DebtCountDown.view.components.core.UIComponent, {
	contructor: function () {
		DebtCountdown.view.components.Manage.superclass.constructor.call(this, "manage", {});
	},
	
	initializeChildren: function() {
		Ext.create('Ext.data.Store', {
		    storeId:'planStore',
		    fields:['name'],
		    data:{'items':[
		        {"name":"Plan One"},
		    ]},
		    proxy: {
		        type: 'memory',
		        reader: {
		            type: 'json',
		            root: 'items'
		        }
		    }
		});
		
		Ext.create('Ext.data.Store', {
		    storeId:'debtStore',
		    fields:['name'],
		    data:{'items':[
		        {"name":"Debt One"},
		    ]},
		    proxy: {
		        type: 'memory',
		        reader: {
		            type: 'json',
		            root: 'items'
		        }
		    }
		});
		
		Ext.create('Ext.grid.Panel', {
			id: 'managePlansGrid',
		    title: 'Manage Plans',
		    store: Ext.data.StoreManager.lookup('planStore'),
		    columns: [
		        {header: 'Name',  dataIndex: 'name'}
		    ],
		    height: 500,
		    width: 400,
		    renderTo: Ext.getBody(),
		    hideHeaders:true
		});
		
		Ext.create('Ext.grid.Panel', {
			id: 'manageDebtsGrid',
		    title: 'Manage Grids',
		    store: Ext.data.StoreManager.lookup('debtStore'),
		    columns: [
		        {header: 'Name',  dataIndex: 'name'}
		    ],
		    height: 500,
		    width: 400,
		    renderTo: Ext.getBody(),
		    hideHeaders:true,
		    hidden: true,
		    hideMode: 'Offsets'
		});
		
		Ext.create('Ext.Button',{
			id: 'managePlansBtn',
			text: 'Manage Plans',
			renderTo: Ext.getBody(),
			scale: 'large',
			enableToggle: true,
			height: 50,
			width: 200,
			pressed: true,
			toggleGroup: "mainNav",
			toggleHandler: function() 
			{
				if(this.pressed)
				{
					Ext.get('managePlansGrid').toggle();
					Ext.get('manageDebtsGrid').toggle();
				}
			}
		});
		
		Ext.create('Ext.Button',{
			id: 'manageDebtsBtn',
			text: 'Manage Debts',
			renderTo: Ext.getBody(),
			scale: 'large',
			enableToggle: true,
			height: 50,
			width: 200,
			toggleGroup: "mainNav",
			toggleHandler: function() 
			{
				if(this.pressed)
				{
					Ext.get('managePlansGrid').toggle();
					Ext.get('manageDebtsGrid').toggle();
				}
			}
		});
	},
	
	childrenInitialize: function() {
		// add listeners after creation
	},
	
	initializationComplete: function() {
		DebtCountDown.view.components.Manage.superclass.initializationComplete.call(this);
	}
});