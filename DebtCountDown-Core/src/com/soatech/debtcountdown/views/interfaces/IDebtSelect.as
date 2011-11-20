package com.soatech.debtcountdown.views.interfaces
{
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;

	public interface IDebtSelect
	{
		function get backBtn():Button;
		function get addBtn():Button;
		function get debtList():List;
		function get instructions():Label;
		function get contBtn():Button;
	}
}