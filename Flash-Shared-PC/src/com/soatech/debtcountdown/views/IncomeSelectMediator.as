package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.MainStackEvent;

	public class IncomeSelectMediator extends IncomeSelectMediatorBase
	{
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
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_INCOME_SELECT, mainStack_switchHandler );
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