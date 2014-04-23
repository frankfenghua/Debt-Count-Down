Ext.namespace('DebtCountDown.view.components');
DebtCountDown.view.components.Manage = Ext.extend(DebtCountDown.view.components.core.UIComponent, {

	debtsGrid: null,
	plansGrid: null,	
	debtStore: null,
	planStore: null,
	
	contructor: function () {
		DebtCountdown.view.components.Manage.superclass.constructor.call(this, "manage", {});
	},
	
	initializeChildren: function() {
		
		this.debtStore = new Ext.data.Store({
			storeId:'debtStore',
		    fields:['name'],
		    proxy: {
		        type: 'memory',
		        reader: {
		            type: 'json',
		            root: 'items'
		        }
		    }
		});
		
		this.planStore = new Ext.data.Store({
			storeId:'planStore',
		    fields:['name'],
		    proxy: {
		        type: 'memory',
		        reader: {
		            type: 'json',
		            root: 'items'
		        }
		    }
		});
		
		this.plansGrid = new Ext.grid.Panel({
			id: 'managePlansGrid',
		    title: 'Manage Plans',
		    store: Ext.data.StoreManager.lookup('planStore'),
		    columns: [
		        {header: 'Name',  dataIndex: 'name'}
		    ],
		    height: 500,
		    width: 400,
		    renderTo: Ext.get('managePlansTab'),
		    hideHeaders:true,
			forceFit: true
		});
		
		this.debtsGrid = new Ext.grid.Panel({
			id: 'manageDebtsGrid',
		    title: 'Manage Grids',
		    store: Ext.data.StoreManager.lookup('debtStore'),
		    columns: [
		        {header: 'Name',  dataIndex: 'name'}
		    ],
		    height: 500,
		    width: 400,
		    renderTo: Ext.get('manageDebtsTab'),
		    hideHeaders:true,
			forceFit: true
		});
		
		Ext.create('Ext.tab.Panel', {
			width: 400,
			height: 500,
			renderTo: Ext.getBody(),
			tabPosition: 'bottom',
			items: [ this.plansGrid, this.debtsGrid ],
			minTabWidth: 195,
			minTabHeight: 100
		});
	},
	
	childrenInitialize: function() {
		// add listeners after creation
	},
	
	initializationComplete: function() {
		DebtCountDown.view.components.Manage.superclass.initializationComplete.call(this);
	},
	
	setDebtStore: function( list /* array */ )
	{
		this.debtStore.loadData(list, false);
	},
	
	setPlanStore: function( list /* array */ )
	{
		this.planStore.loadData(list, false);
	}
});