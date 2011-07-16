package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.MainStackEvent;
	import com.soatech.debtcountdown.views.interfaces.IDebtEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	public class DebtEditMediator extends DebtEditMediatorBase implements IDebtEditMediator
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
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_DEBT_EDIT, mainStack_switchHandler );
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
				dispatch( new DebtEvent( DebtEvent.DELETE, debt ) );
				dispatch( new DebtEvent( DebtEvent.EDIT_BACK ) );
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function deleteBtn_clickHandler(event:MouseEvent):void
		{
			Alert.show("Are you sure you want to delete " + debt.name + "?", 
				"Delete Confirmation", Alert.YES|Alert.NO, null, 
				confirmation_closeHandler);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function mainStack_switchHandler(event:MainStackEvent):void
		{
			// TODO Auto Generated method stub
			setup();
		}
	}
}