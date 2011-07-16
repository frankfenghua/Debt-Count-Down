package com.soatech.debtcountdown.views.interfaces
{
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.TextInput;

	public interface IPlanEdit
	{
		function get backBtn():Button;
		function get debtAddBtn():Button;
		function get debtList():List;
		function get deleteBtn():Button;
		function get expensesTI():TextInput;
		function get incomeTI():TextInput;
		function get nameTI():TextInput;
		function get runBtn():Button;
		function get saveBtn():Button;
		function get instructions():Label;
		function get saveInstructions():Label;
	}
}