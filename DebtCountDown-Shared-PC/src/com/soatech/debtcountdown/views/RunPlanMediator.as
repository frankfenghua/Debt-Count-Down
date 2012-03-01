package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.RunPlanStates;
	import com.soatech.debtcountdown.events.MainStackEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.views.interfaces.IRunPlanMediator;
	
	public class RunPlanMediator extends RunPlanMediatorBase implements IRunPlanMediator
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
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_RUN_PLAN, mainStack_switchHandler );
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