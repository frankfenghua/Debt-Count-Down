package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.views.components.GraphBar;

	public interface IInterestChart
	{
		function get minPaymentBar():GraphBar;
		function get rateBar():GraphBar;
		function get balanceBar():GraphBar;
	}
}