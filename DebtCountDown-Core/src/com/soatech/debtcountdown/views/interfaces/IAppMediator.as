package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.ExpenseEvent;
	import com.soatech.debtcountdown.events.IncomeEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	
	import org.robotlegs.core.IMediator;
	
	public interface IAppMediator extends IMediator
	{
		function budget_createSuccessHandler(event:BudgetEvent):void;
		function budget_editHandler(event:BudgetEvent):void;
		function budget_editBackHandler(event:BudgetEvent):void;
		function budget_newBackHandler(event:BudgetEvent):void;
		function budget_selectBackHandler(event:BudgetEvent):void;
		function dataBase_connectedHandler(event:DataBaseEvent):void;
		function debt_createSuccessHandler(event:DebtEvent):void;
		function debt_editHandler(event:DebtEvent):void;
		function debt_editBackHandler(event:DebtEvent):void;
		function debt_newBackHandler(event:DebtEvent):void;
		function debt_newHandler(event:DebtEvent):void;
		function debt_selectBackHandler(event:DebtEvent):void;
		function debt_selectContinueHandler(event:DebtEvent):void;
		function debt_showSelectHandler(event:DebtEvent):void;
		function expense_newHandler(event:ExpenseEvent):void;
		function expense_selectContinueHandler(event:ExpenseEvent):void;
		function income_newHandler(event:IncomeEvent):void;
		function income_selectContinueHandler(event:IncomeEvent):void;
		function plan_createSuccessHandler(event:PlanEvent):void;
		function plan_editBackHandler(event:PlanEvent):void;
		function plan_newBackHandler(event:PlanEvent):void;
		function plan_newHandler(event:PlanEvent):void;
		function plan_saveSuccessHandler(event:PlanEvent):void;
		function plan_selectedChangedHandler(event:PlanEvent):void;
		function paymentPlan_backHandler(event:PaymentPlanEvent):void;
		function paymentPlan_showRunHandler(event:PaymentPlanEvent):void;
		function paymentPlan_detailsHandler(event:PaymentPlanEvent):void;
	}
}