package com.soatech.debtcountdown.views
{
	import avmplus.FLASH10_FLAGS;
	
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.views.interfaces.IAppMediator;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AppMediatorBase extends Mediator implements IAppMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( eventDispatcher, DebtEvent.CREATE_SUCCESS, debt_createSuccessHandler );
			eventMap.mapListener( eventDispatcher, DebtEvent.EDIT, debt_editHandler );
			eventMap.mapListener( eventDispatcher, DebtEvent.EDIT_BACK, debt_editBackHandler );
			eventMap.mapListener( eventDispatcher, DebtEvent.NEW_BACK, debt_newBackHandler );
			eventMap.mapListener( eventDispatcher, DebtEvent.NEW_DEBT, debt_newHandler );
			eventMap.mapListener( eventDispatcher, DebtEvent.SELECT_BACK, debt_selectBackHandler );
			eventMap.mapListener( eventDispatcher, DebtEvent.SHOW_SELECT, debt_showSelectHandler );
			
			eventMap.mapListener( eventDispatcher, PaymentPlanEvent.BACK, paymentPlan_backHandler );
			eventMap.mapListener( eventDispatcher, PaymentPlanEvent.SHOW_RUN, paymentPlan_showRunHandler );
			eventMap.mapListener( eventDispatcher, PaymentPlanEvent.DETAILS, paymentPlan_detailsHandler );
			
			eventMap.mapListener( eventDispatcher, PlanEvent.CREATE_SUCCESS, plan_createSuccessHandler );
			eventMap.mapListener( eventDispatcher, PlanEvent.EDIT_BACK, plan_editBackHandler );
			eventMap.mapListener( eventDispatcher, PlanEvent.NEW_BACK, plan_newBackHandler );
			eventMap.mapListener( eventDispatcher, PlanEvent.NEW_PLAN, plan_newHandler );
			eventMap.mapListener( eventDispatcher, PlanEvent.SELECTED_CHANGED, plan_selectedChangedHandler );
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		public function debt_createSuccessHandler(event:DebtEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function debt_editHandler(event:DebtEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function debt_editBackHandler(event:DebtEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function debt_newBackHandler(event:DebtEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function debt_newHandler(event:DebtEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function debt_selectBackHandler(event:DebtEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function debt_showSelectHandler(event:DebtEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function plan_createSuccessHandler(event:PlanEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function plan_editBackHandler(event:PlanEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function plan_newBackHandler(event:PlanEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function plan_newHandler(event:PlanEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function plan_selectedChangedHandler(event:PlanEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function paymentPlan_backHandler(event:PaymentPlanEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function paymentPlan_showRunHandler(event:PaymentPlanEvent):void
		{
			trace("Not Yet Implemented");
		}
		
		public function paymentPlan_detailsHandler(event:PaymentPlanEvent):void
		{
			trace("Not Yet Implemented");
		}
	}
}