App.views.PlanEdit = Ext.extend(Ext.form.FormPanel, {
	defaultInstructions: 'Please enter the information above.',
	
	initComponent: function() {
		var titlebar, cancelBtn, buttonbar, saveBtn, deleteBtn, fields;
		
		cancelBtn = {
			text: 'Cancel',
			ui: 'back',
			handler: this.cancelBtn_clickHandler,
			scope: this	
		};
		
		titlebar = {
			id: 'planEditTitlebar',
			xtype: 'toolbar',
			title: 'Plan Details',
			items: [ cancelBtn ]
		};
		
		saveBtn = {
			id: 'planEditSaveBtn',
			text: 'Save',
			ui: 'confirm',
			handler: this.saveBtn_clickHandler,
			scope: this
		};
		
		deleteBtn = {
			id: 'planEditDeleteBtn',
			text: 'Delete',	
			ui: 'decline',
			handler: this.deleteBtn_clickHandler,
			scope: this
		};
		
		buttonbar = {
			xtype: 'toolbar',
			dock: 'bottom',
			items: [ deleteBtn, { xtype: 'spacer' }, saveBtn ]	
		};
		
		fields = {
			xtype: 'fieldset',
			id: 'planEditFieldset',
			title: 'Plan Details',
			instructions: this.defaultInstructions,
			defaults: {
				xtype: 'textfield',
				labelAlign: 'left',
				labelWidth: '40%',
				required: false,
				useClearIcon: true,
				autoCapitalize: false	
			},
			items: [
				{
					name: 'name',
					label: 'Name',
					autoCapitalize: true
				},
				{
					xtype: 'App.views.ErrorField',
					fieldname: 'name'
				},
				{
					name: 'income',
					label: 'Income'
				},
				{
					xtype: 'App.views.ErrorField',
					fieldname: 'income'
				},
				{
					name: 'expenses',
					label: 'Expenses'
				},
				{
					xtype: 'App.views.ErrorField',
					fieldname: 'expenses'
				},
			]
		};
		
		Ext.apply( this, {
			scroll: 'vertical',
			dockedItems: [ titlebar, buttonbar ],
			items: [ fields ],
			listeners: {
				beforeactivate: function() {
					var deleteBtn = this.down("#planEditDeleteBtn"),
					saveBtn = this.down("#planEditSaveBtn"),
					titlebar = this.down("#planEditTitlebar"),
					model = this.getRecord();
					
					if(model.phantom) {
						titlebar.setTitle('Create Plan');
						saveBtn.setText('create');
						deleteBtn.hide();
					} else {
						titlebar.setTitle('Update Plan');
						saveBtn.setText('update');
						deleteBtn.show();
					}
				},
				deactivate: function() { this.resetForm() }
			}	
		});
		
		App.views.PlanEdit.superclass.initComponent.call(this);
	},
	
	cancelBtn_clickHandler: function() {
		Ext.dispatch({
			controller: 'Plans',
			action: 'index'	
		});
	},
	
	saveBtn_clickHandler: function() {
		var model = this.getRecord();
		
		Ext.dispatch({
			controller: 'Plans',
			action: (model.phantom ? 'save' : 'update'),
			data: this.getValues(),
			record: model,
			form: this	
		});
	},
	
	deleteBtn_clickHandler: function() {
		Ext.Msg.confirm("Delete this plan?", "", function(answer) {
			if( answer === "yes" ) {
				Ext.dispatch({
					controller: 'Plans',
					action: 'remove',
					record: this.getRecord()	
				});
			}
		}, this);
	},
	
	showErrors: function(errors) {
		var fieldset = this.down('#planEditFieldset');
		this.fields.each(function(field){
			var fieldErrors = errors.getByField(field.name);
			
			if( fieldErrors.length > 0 ) {
				var errorField = this.down('#' + field.name + 'ErrorField');
				field.addCls('invalid-field');
				errorField.update(fieldErrors);
				errorField.show();
			} else {
				this.resetField(field);
			}
		}, this);
		
		fieldset.setInstructions('Please amend the flagged fields');
	},
	
	resetForm: function() {
		var fieldset = this.down('#planEditFieldset');
		this.fields.each(function(field) {
			this.resetField(field);
		}, this);
		fieldset.setInstructions(this.defaultInstructions);
		this.reset();
	},
	
	resetField: function(field) {
		var errorField = this.down('#' + field.name + 'ErrorField');
		errorField.hide();
		field.removeCls('invalid-field');
		return errorField;
	}
	

});

Ext.reg('App.views.PlanEdit', App.views.PlanEdit);