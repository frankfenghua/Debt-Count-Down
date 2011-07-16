package com.soatech.debtcountdown.views.interfaces
{
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;

	public interface IPlanSelect
	{
		function get addBtn():Button;
		function get planList():List;
		function get instructions():Label;
	}
}