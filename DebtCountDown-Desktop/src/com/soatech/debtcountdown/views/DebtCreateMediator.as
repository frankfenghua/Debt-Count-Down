package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.views.components.DebtEdit;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class DebtCreateMediator extends Mediator implements IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():DebtEdit
		{
			return viewComponent as DebtEdit;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			view.saveBtn.addEventListener(MouseEvent.CLICK, saveBtn_clickHandler);
			view.cancelBtn.addEventListener(MouseEvent.CLICK, cancelBtn_clickHandler);
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
		protected function cancelBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new DebtEvent( DebtEvent.NEW_BACK ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function saveBtn_clickHandler(event:MouseEvent):void
		{
			
		}
	}
}