package com.soatech.debtcountdown.views.interfaces
{
	import spark.components.Button;
	import spark.components.List;

	public interface IPaymentPlan
	{
		function get actionList():List;
		function get backBtn():Button;
		function set title(value:String):void;
	}
}