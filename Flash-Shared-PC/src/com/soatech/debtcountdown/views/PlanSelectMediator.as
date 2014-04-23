package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.MainStackEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.views.components.PlanSelect;
	import com.soatech.debtcountdown.views.interfaces.IPlanSelectMediator;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayList;
	
	import org.osmf.events.PlayEvent;
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class PlanSelectMediator extends PlanSelectMediatorBase implements IPlanSelectMediator
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
		//--------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_PLAN_SELECT, mainStack_switchHandler );
			
			populate();
			setup();
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
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