package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.MainStackEvent;

	public class ExpenseSelectMediator extends ExpenseSelectMediatorBase
	{
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_EXPENSE_SELECT, mainStack_switchHandler );
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
		protected function mainStack_switchHandler(event:MainStackEvent):void
		{
			setup();
		}
	}
}