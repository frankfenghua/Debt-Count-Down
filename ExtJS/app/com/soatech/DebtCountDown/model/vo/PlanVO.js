Ext.namespace('DebtCountDown.model.vo');
DebtCountDown.model.vo.PlanVO = function(pid /* int */, expenses /* float */, income /* float */, name /* string */ )
{
	this.pid = pid;
	this.expenses = expenses;
	this.income = income;
	this.name = name;
};