package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DeleteConfirmEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.components.DeleteConfirm;
	import com.soatech.debtcountdown.views.components.PlanEdit;
	import com.soatech.debtcountdown.views.interfaces.IPlanEditMediator;
	
	import flash.events.MouseEvent;
	
	public class PlanEditMedaitor extends PlanEditMediatorBase implements IPlanEditMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// localView
		//-----------------------------
		
		public function get localView():PlanEdit
		{
			return viewComponent as PlanEdit;
		}
		
		//-----------------------------
		// plan
		//-----------------------------
		
		override public function get plan():PlanVO
		{
			return localView.data as PlanVO;
		}
		
		override public function set plan(value:PlanVO):void
		{
			localView.data = value;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var deleteConfirm:DeleteConfirm;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function deleteBtn_clickHandler(event:MouseEvent):void
		{
			event.preventDefault();
			event.stopImmediatePropagation();
			
			deleteConfirm = new DeleteConfirm();
			deleteConfirm.addEventListener( DeleteConfirmEvent.NO, confirmation_closeHandler );
			deleteConfirm.addEventListener( DeleteConfirmEvent.YES, confirmation_closeHandler );
			deleteConfirm.open(localView);
			
			this.mediatorMap.createMediator(deleteConfirm);
		}
		
		/**
		 * 
		 * 
		 */		
		override public function onRegister():void
		{
			super.onRegister();
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
		protected function confirmation_closeHandler(event:DeleteConfirmEvent):void
		{
			if( event.type == DeleteConfirmEvent.YES )
			{
				dispatch( new PlanEvent( PlanEvent.DELETE, plan ) );
				dispatch( new PlanEvent( PlanEvent.EDIT_BACK ) );
			}
		}
	}
}