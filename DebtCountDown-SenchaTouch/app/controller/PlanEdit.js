Ext.define('DCD.controller.PlanEdit', {
	extend: 'Ext.app.Controller',

	views: ['PlanEdit'],

	//-------------------------------------------------------------------------
	//
	// Configuration
	//
	//-------------------------------------------------------------------------

	config: {

		//-----------------------------
		// References
		//-----------------------------

		refs: {
			saveBtn: {
				xtype: 'button',
				selector: 'button[name=plan-save-btn]'
			},
			deleteBtn: {
				xtype: 'button',
				selector: 'button[name=plan-delete-btn]'
			},
			continueBtn: {
				xtype: 'button',
				selector: 'button[name=plan-cont-btn]'
			},
			name: {
				xtype: 'textfield',
				selector: 'fieldset[name=plan-form] textfield[name=name]'
			},
			pid: {
				xtype: 'hiddenfield',
				selector: 'fieldset[name=plan-form] hiddenfield[name=pid]'
			},
			view: {
				xtype: 'panel',
				selector: 'panel[name=plan-edit-panel]'
			}
		},

		//-----------------------------
		// Listeners
		//-----------------------------

		control: {
			saveBtn: {
				tap: 'onSaveBtnTap'
			},
			deleteBtn: {
				tap: 'onDeleteBtnTap'
			},
			continueBtn: {
				tap: 'onContinueBtnTap'
			},
			name: {
				change: 'onNameChange',
				keyup: 'onNameChange',
				paste: 'onNameChange'
			},
			view: {
				show: 'onViewShow'
			}
		}
	},

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	buildSaveCall: function(callback) {
		var pid = this.getPid().getValue();
		var savePlan = Ext.create('DCD.model.Plan', {name: this.getName().getValue(), pid: this.getPid().getValue()});
		var action = 'create';
		
		if( pid && pid.length ) {
			action =  'update';
		}

		savePlan.save({
			action: action,
			callback: callback,
			params: {'plan[pid]': savePlan.data.pid, 'plan[name]': savePlan.data.name},
			scope: this
		});
	},

	savePlan: function(plan) {
		var planStore = Ext.getStore('Plans');

		// see if plan exists
		var planIndex = planStore.find('pid', plan.data.pid);

		// if it does, replace it
		if( planIndex > -1 )
		{
			var oldPlan = planStore.findRecord('pid', plan.data.pid);
			oldPlan.setData(plan.data);

			planStore.remove(oldPlan);
			planStore.add(oldPlan);
		}
		else // if it doesn't, add it
		{
			planStore.add(Ext.create('DCD.model.Plan', plan.data));
		}
	},

	//-------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//-------------------------------------------------------------------------

	onContinueBtnTap: function() {
		// save and move onto next screen

		this.buildSaveCall(this.onContinueSuccess);
	},

	onDeleteBtnTap: function() {
		// remove record and go back to Manage Plans
		var savePlan = Ext.create('DCD.model.Plan', {name: this.getName().getValue(), pid: this.getPid().getValue()});

		savePlan.erase({
			action: 'destroy',
			callback: this.onDeleteSuccess,
			scope: this,
			params: {pid: savePlan.data.pid}
		});
	},

	onNameChange: function() {
		var val = this.getName().getValue();

		if( val && val.length )
		{
			this.getContinueBtn().enable();
			this.getSaveBtn().enable();
		}
		else
		{
			this.getContinueBtn().disable();
			this.getSaveBtn().disable();
		}
	},

	onSaveBtnTap: function() {
		// save and return to Manage Plans

		this.buildSaveCall(this.onSaveSuccess);
	},

	onViewShow: function() {
		console.log("PlanEdit::show");

		var me = this.getView();

		var planContBtn = this.getContinueBtn();
		var planDelBtn = this.getDeleteBtn();

		// populate the view with plan data
		me.setValues({
			name: null
		});

		planContBtn.disable();
		planDelBtn.disable();
		this.getSaveBtn().disable();

		if( me.plan )
		{
			me.setValues({
				name: me.plan.name,
				pid: me.plan.pid
			});

			if( me.plan.pid && me.plan.pid.length )
			{
				planDelBtn.enable();
			}

			if( me.plan.name && me.plan.name.length )
			{
				planContBtn.enable();
				this.getSaveBtn().enable();
			}
		}
	},

	//-------------------------------------------------------------------------
	//
	// Result Handlers
	//
	//-------------------------------------------------------------------------

	onContinueSuccess: function(plan, action) {
		var me = action.getScope();

		me.savePlan(plan);

		var manageDebts = Ext.create('DCD.view.ManageDebts');
		manageDebts.plan = plan;
		Ext.ComponentManager.get('Navigator').push(manageDebts);
	},

	onDeleteSuccess: function(plan, action) {
		var planStore = Ext.getStore('Plans');

		var planIndex = planStore.find('pid', plan.data.pid);

		planStore.removeAt(planIndex);

		Ext.ComponentManager.get('Navigator').pop(1);
	},

	onSaveSuccess: function(plan, action) {
		var me = action.getScope();

		me.savePlan(plan);

		Ext.ComponentManager.get('Navigator').pop(1);
	}
	
});