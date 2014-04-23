package com.soatech.debtcountdown.views.interfaces
{
	import mx.charts.BarChart;
	
	import spark.components.Button;

	public interface IRunPlan
	{
		function get backBtn():Button;
		function get busyInd():*;
		function setState(value:String):void;
	}
}