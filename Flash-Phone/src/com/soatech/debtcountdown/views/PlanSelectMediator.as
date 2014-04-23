package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.views.components.PlanSelect;
	import com.soatech.debtcountdown.views.interfaces.IPlanSelectMediator;
	
	import mx.events.StateChangeEvent;
	
	public class PlanSelectMediator extends PlanSelectMediatorBase implements IPlanSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// localView
		//-----------------------------
		
		public function get localView():PlanSelect
		{
			return view as PlanSelect;
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
			
			if( localView.data as String )
				localView.currentState = localView.data as String;
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		override public function view_stateChangeHandler(event:StateChangeEvent):void
		{
			super.view_stateChangeHandler(event);
			
			localView.data = event.newState;
		}
	}
}