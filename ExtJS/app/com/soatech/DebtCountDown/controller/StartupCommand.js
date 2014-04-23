Ext.namespace('DebtCountDown.controller');
DebtCountDown.controller.StartupCommand = Ext.extend(Puremvc.patterns.MacroCommand, {
	initializeMacroCommand: function()
	{
		this.addSubCommand(DebtCountDown.controller.ModelPrepCommand);
		this.addSubCommand(DebtCountDown.controller.ViewPrepCommand);
	}
});