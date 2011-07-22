Ext.namespace('DebtCountDown.model.vo');
DebtCountDown.model.vo.StatsVO = function(monthsToPayOff /* int */, totalInterestPaid /* float */, paymentRemaining /* float */, paymentPlan /* array */)
{
	this.monthsToPayOff = monthsToPayOff;
	this.totalInterestPaid = totalInterestPaid;
	this.paymentRemaining = paymentRemaining;
	this.paymentPlan = paymentPlan;
};