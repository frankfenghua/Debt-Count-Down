package com.soatech.debtcountdown.views.interfaces
{
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.TextInput;

	public interface IPlanEdit
	{
		function get backBtn():Button;
		function get contBtn():Button;
		function get deleteBtn():Button;
		function get instructions():Label;
		function get nameTI():TextInput;
		function get saveBtn():Button;
	}
}