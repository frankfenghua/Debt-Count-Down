package com.soatech.debtcountdown.views.interfaces
{
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;

	public interface IDebtSelect
	{
		function get addBtn():Button;
		function get addInstructions():Label;
		function get backBtn():Button;
		function get contBtn():Button;
		function get debtList():List;
		function get toggleInstructions():Label;
	}
}