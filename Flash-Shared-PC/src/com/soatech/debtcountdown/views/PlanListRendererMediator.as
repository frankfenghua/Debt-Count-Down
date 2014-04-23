package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.views.renderers.PlanListRenderer;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class PlanListRendererMediator extends Mediator implements IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():PlanListRenderer
		{
			return viewComponent as PlanListRenderer;
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
				dispatch( new PlanEvent( PlanEvent.DELETE, view.plan ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function deleteBtn_clickHandler(event:MouseEvent):void
		{
			Alert.show("Are you sure you want to delete " + view.plan.name + "?", 
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
			dispatch( new PlanEvent( PlanEvent.SELECT, view.plan ) );
		}
	}
}