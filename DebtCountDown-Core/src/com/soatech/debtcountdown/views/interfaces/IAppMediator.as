package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	
	import org.robotlegs.core.IMediator;
	
	public interface IAppMediator extends IMediator
	{
		function debt_createSuccessHandler(event:DebtEvent):void;
		function debt_editHandler(event:DebtEvent):void;
		function debt_editBackHandler(event:DebtEvent):void;
		function debt_newBackHandler(event:DebtEvent):void;
		function debt_newHandler(event:DebtEvent):void;
		function debt_selectBackHandler(event:DebtEvent):void;
		function debt_showSelectHandler(event:DebtEvent):void;
		function plan_createSuccessHandler(event:PlanEvent):void;
		function plan_editBackHandler(event:PlanEvent):void;
		function plan_newBackHandler(event:PlanEvent):void;
		function plan_newHandler(event:PlanEvent):void;
		function plan_selectedChangedHandler(event:PlanEvent):void;
		function paymentPlan_backHandler(event:PaymentPlanEvent):void;
		function paymentPlan_showRunHandler(event:PaymentPlanEvent):void;
		function paymentPlan_detailsHandler(event:PaymentPlanEvent):void;
	}
}