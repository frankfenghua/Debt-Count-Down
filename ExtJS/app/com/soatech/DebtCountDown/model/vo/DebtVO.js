Ext.namespace('DebtCountDown.model.vo');
DebtCountDown.model.vo.DebtVO = function(pid /* int */, planId /* int */, name /* string */, bank /* string */, balance /* float */, apr /* float */, minPayment /* float */)
{
	this.pid = pid;
	this.planId = planId;
	this.name = name;
	this.bank = bank;
	this.balance = balance;
	this.apr = apr;
	this.minPayment = minPayment;
};