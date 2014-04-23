package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.ExpenseEvent;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	
	import flash.events.MouseEvent;

	public interface IExpenseEditMediator
	{
		function get expenseItem():BudgetItemVO;
		function set expenseItem(value:BudgetItemVO):void;
		function get view():IExpenseEdit;
		function populate():void;
		function setup():void;
		function validateAll():Boolean;
		function backBtn_clickHandler(event:MouseEvent):void;
		function deleteBtn_clickHandler(event:MouseEvent):void;
		function expense_saveSuccessHandler(event:BudgetEvent):void;
		function saveBtn_clickHandler(event:MouseEvent):void;
	}
}