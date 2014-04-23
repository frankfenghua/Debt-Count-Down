package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.RotateEvent;
	import com.soatech.debtcountdown.views.components.DropDownList;
	
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class DropDownListMediator extends Mediator implements IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():DropDownList
		{
			return viewComponent as DropDownList;
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
			
			eventMap.mapListener( eventDispatcher, RotateEvent.ROTATED, rotatedHandler );
			
			eventMap.mapListener( view.itemList, IndexChangeEvent.CHANGE, itemList_changeHandler );
			eventMap.mapListener( view.closeBtn, MouseEvent.CLICK, closeBtn_clickHandler );
			
			adjustSize();
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		protected function adjustSize():void
		{
			view.width = FlexGlobals.topLevelApplication.width - 40;
			view.height = Math.min(view.dataProvider.length * 90, FlexGlobals.topLevelApplication.height - 40);
			view.x = FlexGlobals.topLevelApplication.width/2 - view.width/2;
			view.y = FlexGlobals.topLevelApplication.height/2 - view.height/2;
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
		protected function closeBtn_clickHandler(event:MouseEvent):void
		{
			view.close();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function itemList_changeHandler(event:IndexChangeEvent):void
		{
			view.dispatchEvent( event.clone() );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function rotatedHandler(event:RotateEvent):void
		{
			adjustSize();
		}
	}
}