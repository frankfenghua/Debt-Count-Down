package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	
	import mx.core.IUIComponent;
	
	import spark.components.Button;
	import spark.components.TextInput;
	

	public interface IDebtEdit
	{
		function get backBtn():Button;
		function get saveBtn():Button;
		function get nameTI():TextInput;
		function get bankTI():TextInput;
		function get balanceTI():TextInput;
		function get aprTI():TextInput;
		function get minPaymentTI():TextInput;
		function get deleteBtn():Button;
		function get removeFromPlanBtn():Button;
		function setState(value:String):void;
	}
}