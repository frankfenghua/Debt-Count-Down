package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.IncomeEvent;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	
	import flash.events.MouseEvent;

	public interface IIncomeEditMediator
	{
		function get incomeItem():BudgetItemVO;
		function set incomeItem(value:BudgetItemVO):void;
		function get view():IIncomeEdit;
		function populate():void;
		function setup():void;
		function validateAll():Boolean;
		function backBtn_clickHandler(event:MouseEvent):void;
		function deleteBtn_clickHandler(event:MouseEvent):void;
		function income_saveSuccessHandler(event:BudgetEvent):void;
		function saveBtn_clickHandler(event:MouseEvent):void;
	}
}