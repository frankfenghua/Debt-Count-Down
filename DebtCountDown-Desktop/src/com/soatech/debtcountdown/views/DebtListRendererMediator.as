package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.views.renderers.DebtListRenderer;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class DebtListRendererMediator extends Mediator implements IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var planProxy:PlanProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():DebtListRenderer
		{
			return viewComponent as DebtListRenderer;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override public function onRegister():void
		{
			super.onRegister();
			
			// view events
			eventMap.mapListener( view.selectBtn, MouseEvent.CLICK, selectBtn_clickHandler );
			eventMap.mapListener( view.deleteBtn, MouseEvent.CLICK, deleteBtn_clickHandler );
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
		protected function confirmation_closeHandler(event:CloseEvent):void
		{
			if( event.detail == Alert.YES )
			{
				if( planProxy.selectedPlan )
				{
					dispatch( new PlanEvent( PlanEvent.UNLINK_DEBT, planProxy.selectedPlan, null, view.debt ) );
				}
				else
				{
					dispatch( new DebtEvent( DebtEvent.DELETE, view.debt ) );
				}
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function deleteBtn_clickHandler(event:MouseEvent):void
		{
			Alert.show("Are you sure you want to remove " + view.debt.name + "?", 
				"Delete Confirmation", Alert.YES|Alert.NO, null, 
				confirmation_closeHandler);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function selectBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new DebtEvent( DebtEvent.SELECT, view.debt ) );
			dispatch( new DebtEvent( DebtEvent.EDIT, view.debt ) );
		}
	}
}