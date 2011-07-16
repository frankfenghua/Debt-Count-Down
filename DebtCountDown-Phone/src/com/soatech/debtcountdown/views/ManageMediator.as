package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.views.components.Manage;
	
	import flash.events.Event;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class ManageMediator extends Mediator implements IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():Manage
		{
			return viewComponent as Manage;
		}
		
		//-----------------------------
		// lastSelectedTab
		//-----------------------------
		
		public function get lastSelectedTab():int
		{
			return view.data as int;
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
			
			view.tabViewNavigator.addEventListener(IndexChangeEvent.CHANGE, tabIndexChangeHandler );
			
			view.tabViewNavigator.selectedIndex = lastSelectedTab;
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
		protected function tabIndexChangeHandler(event:IndexChangeEvent):void
		{
			view.data = event.newIndex;
		}
	}
}