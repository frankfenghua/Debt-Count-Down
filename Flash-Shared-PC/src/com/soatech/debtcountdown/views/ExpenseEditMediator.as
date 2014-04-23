package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.MainStackEvent;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class ExpenseEditMediator extends ExpenseEditMediatorBase
	{
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_EXPENSE_EDIT, mainStack_switchHandler );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function deleteBtn_clickHandler(event:MouseEvent):void
		{
			Alert.show("Are you sure you want to delete " + expenseItem.name + "?",
				"Delete Confirmation", Alert.YES|Alert.NO, null, confirmation_closeHandler);
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
				dispatch( new BudgetEvent( BudgetEvent.DELETE, expenseItem ) );
				dispatch( new BudgetEvent( BudgetEvent.EDIT_BACK ) );
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function mainStack_switchHandler(event:MainStackEvent):void
		{
			setup();
		}
	}
}