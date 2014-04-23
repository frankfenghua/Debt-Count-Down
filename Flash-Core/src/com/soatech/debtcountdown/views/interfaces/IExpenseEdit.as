package com.soatech.debtcountdown.views.interfaces
{
	import spark.components.Button;
	import spark.components.TextInput;
	
	public interface IExpenseEdit
	{
		function get amountTI():TextInput;
		function get backBtn():Button;
		function get deleteBtn():Button;
		function get nameTI():TextInput;
		function get saveBtn():Button;
	}
}