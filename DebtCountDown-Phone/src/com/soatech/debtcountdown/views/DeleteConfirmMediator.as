package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DeleteConfirmEvent;
	import com.soatech.debtcountdown.views.components.DeleteConfirm;
	
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class DeleteConfirmMediator extends Mediator implements IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():DeleteConfirm
		{
			return viewComponent as DeleteConfirm;
		}
		
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( view.yesBtn, MouseEvent.CLICK, yesBtn_clickHandler);
			eventMap.mapListener( view.noBtn, MouseEvent.CLICK, noBtn_clickHandler);
			
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
		protected function noBtn_clickHandler(event:MouseEvent):void
		{
			view.dispatchEvent( new DeleteConfirmEvent( DeleteConfirmEvent.NO ) );
			view.close();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function yesBtn_clickHandler(event:MouseEvent):void
		{
			view.dispatchEvent( new DeleteConfirmEvent( DeleteConfirmEvent.YES ) );
			view.close();
		}
		
	}
}