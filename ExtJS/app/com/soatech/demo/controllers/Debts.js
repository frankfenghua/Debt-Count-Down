Ext.regController('Debts', {
	store: App.stores.debts,
	
	index: function() {
		App.views.viewport.reveal('manageDebts');
	},
	
	newDebt: function() {
		var model = new App.models.Debt();
		App.views.debtEdit.load(model);
		App.views.viewport.reveal('debtEdit');
	},
	
	editDebt: function(params) {
		var model = this.store.getAt(params.index);
		App.views.debtEdit.load(model);
		App.views.viewport.reveal('debtEdit');
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
		var tmp = new App.models.Debt(params.data),
			errors = tmp.validate();
			
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