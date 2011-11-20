package com.soatech.debtcountdown.views.interfaces
{
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;

	public interface IIncomeSelect
	{
		function get addBtn():Button
		function get backBtn():Button
		function get incomeList():List
		function get instructions():Label
		function get contBtn():Button
	}
}