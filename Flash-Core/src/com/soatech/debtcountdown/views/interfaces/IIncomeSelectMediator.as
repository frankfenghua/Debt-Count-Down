package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.SelectToggleEvent;
	
	import flash.events.MouseEvent;
	
	import spark.events.IndexChangeEvent;
	
	public interface IIncomeSelectMediator
	{
		function get view():IIncomeSelect;
		
		function addBtn_clickHandler(event:MouseEvent):void;
		function backBtn_clickHandler(event:MouseEvent):void;
		function contBtn_clickHandler(event:MouseEvent):void;
		function incomeList_changeHandler(event:BudgetEvent):void;
		function incomeList_selectEditHandler(event:SelectToggleEvent):void;
		function setup():void;
	}
}