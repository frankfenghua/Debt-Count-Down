package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.events.RotateEvent;
	import com.soatech.debtcountdown.views.components.DebtDetails;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.components.Manage;
	import com.soatech.debtcountdown.views.components.PaymentPlan;
	import com.soatech.debtcountdown.views.components.PlanDetails;
	import com.soatech.debtcountdown.views.components.RunPlan;
	import com.soatech.debtcountdown.views.interfaces.IAppMediator;
	
	import mx.events.ResizeEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class AppMediator extends AppMediatorBase implements IAppMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():DebtCountDownPhone
		{
			return viewComponent as DebtCountDownPhone;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( view, ResizeEvent.RESIZE, resizeHandler );
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function resizeHandler(event:ResizeEvent):void
		{
			dispatch( new RotateEvent( RotateEvent.ROTATED ) );
		}
		
		override public function dataBase_connectedHandler(event:DataBaseEvent):void
		{
			view.navigator.pushView( Manage );
		}
		
		override public function debt_createSuccessHandler(event:DebtEvent):void
		{
			view.navigator.popView();
		}
		
		override public function debt_editHandler(event:DebtEvent):void
		{
			view.navigator.pushView( DebtDetails, event.debt );
		}
		
		override public function debt_editBackHandler(event:DebtEvent):void
		{
			view.navigator.popView();
		}
		
		override public function debt_newBackHandler(event:DebtEvent):void
		{
			view.navigator.popView();
		}
		
		override public function debt_newHandler(event:DebtEvent):void
		{
			view.navigator.pushView( DebtDetails, event.debt );
		}
		
		override public function debt_selectBackHandler(event:DebtEvent):void
		{
			view.navigator.popView();
		}
		
		override public function debt_showSelectHandler(event:DebtEvent):void
		{
			view.navigator.pushView( DebtSelect, event.plan );
		}
		
		override public function plan_createSuccessHandler(event:PlanEvent):void
		{
			
		}
		
		override public function plan_editBackHandler(event:PlanEvent):void
		{
			view.navigator.popView();
		}
		
		override public function plan_newBackHandler(event:PlanEvent):void
		{
			view.navigator.popView();
		}
		
		override public function plan_newHandler(event:PlanEvent):void
		{
			view.navigator.pushView( PlanDetails, event.plan );
		}
		
		override public function plan_selectedChangedHandler(event:PlanEvent):void
		{
			view.navigator.pushView( PlanDetails, event.plan );
		}
		
		override public function paymentPlan_backHandler(event:PaymentPlanEvent):void
		{
			view.navigator.popView();
		}
		
		override public function paymentPlan_showRunHandler(event:PaymentPlanEvent):void
		{
			view.navigator.pushView( RunPlan, event.plan );
		}
		
		override public function paymentPlan_detailsHandler(event:PaymentPlanEvent):void
		{
			view.navigator.pushView( PaymentPlan );
		}
	}
}