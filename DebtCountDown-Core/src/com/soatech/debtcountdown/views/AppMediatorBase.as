package com.soatech.debtcountdown.views
{
	import avmplus.FLASH10_FLAGS;
	
	import com.soatech.debtcountdown.events.DataBaseEvent;
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
			
			addContextListener( DataBaseEvent.CONNECTED, dataBase_connectedHandler );
			
			addContextListener( DebtEvent.CREATE_SUCCESS, debt_createSuccessHandler );
			addContextListener( DebtEvent.EDIT, debt_editHandler );
			addContextListener( DebtEvent.EDIT_BACK, debt_editBackHandler );
			addContextListener( DebtEvent.NEW_BACK, debt_newBackHandler );
			addContextListener( DebtEvent.NEW_DEBT, debt_newHandler );
			addContextListener( DebtEvent.SELECT_BACK, debt_selectBackHandler );
			addContextListener( DebtEvent.SHOW_SELECT, debt_showSelectHandler );
			
			addContextListener( PaymentPlanEvent.BACK, paymentPlan_backHandler );
			addContextListener( PaymentPlanEvent.SHOW_RUN, paymentPlan_showRunHandler );
			addContextListener( PaymentPlanEvent.DETAILS, paymentPlan_detailsHandler );
			
			addContextListener( PlanEvent.CREATE_SUCCESS, plan_createSuccessHandler );
			addContextListener( PlanEvent.EDIT_BACK, plan_editBackHandler );
			addContextListener( PlanEvent.NEW_BACK, plan_newBackHandler );
			addContextListener( PlanEvent.NEW_PLAN, plan_newHandler );
			addContextListener( PlanEvent.SELECTED_CHANGED, plan_selectedChangedHandler );
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		public function dataBase_connectedHandler(event:DataBaseEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function debt_createSuccessHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function debt_editHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function debt_editBackHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function debt_newBackHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function debt_newHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function debt_selectBackHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function debt_showSelectHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function plan_createSuccessHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function plan_editBackHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function plan_newBackHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function plan_newHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function plan_selectedChangedHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function paymentPlan_backHandler(event:PaymentPlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function paymentPlan_showRunHandler(event:PaymentPlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
		
		public function paymentPlan_detailsHandler(event:PaymentPlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented"); };
		}
	}
}