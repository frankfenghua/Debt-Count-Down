Ext.namespace('DebtCountDown.model.vo');
DebtCountDown.model.vo.PaymentPlanVO = function(debt /* DebtVO */, payment /* float */, balance /* float */, month /* int */)
{
	this.debt = debt;
	this.payment = payment;
	this.balance = balance;
	this.month = month;
};