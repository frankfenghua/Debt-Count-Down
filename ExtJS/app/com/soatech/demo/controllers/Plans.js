Ext.regController('Plans', {
	store: App.stores.plans,
	
	index: function() {
		App.views.viewport.reveal('managePlans');
	},
	
	newPlan: function() {
		var model = new App.models.Plan();
		App.views.planEdit.load(model);
		App.views.viewport.reveal('planEdit');
	},
	
	editPlan: function(params) {
		var model = this.store.getAt(params.index);
		App.views.planEdit.load(model);
		App.views.viewport.reveal('planEdit');
	},
	
	save: function(params) {
		params.record.set(params.data);
		var errors = params.record.validate();
		
		if( errors.isValid()) {
			this.store.create(params.data);
			this.index();
		} else {
			params.form.showErrors(errors);
		}
	},
	
	update: function(params){
		var tmpPlan = new App.models.Plan(params.data),
			errors = tmpPlan.validate();
			
		if( errors.isValid() )
		{
			params.record.set(params.data);
			params.record.save();
			this.index();
		} else {
			params.form.showErrors(errors);
		}
	},
	
	remove: function(params) {
		this.store.remove(params.record);
		this.store.sync();
		this.index();
	}
});