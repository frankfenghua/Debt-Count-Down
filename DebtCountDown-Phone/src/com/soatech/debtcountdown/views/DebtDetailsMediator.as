package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DatePickerEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.DeleteConfirmEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.services.PayOffService;
	import com.soatech.debtcountdown.views.components.DebtDetails;
	import com.soatech.debtcountdown.views.components.DeleteConfirm;
	import com.soatech.debtcountdown.views.interfaces.IDebtEdit;
	import com.soatech.debtcountdown.views.interfaces.IDebtEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.events.ResizeEvent;
	import mx.validators.Validator;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.TextOperationEvent;
	
	public class DebtDetailsMediator extends DebtEditMediatorBase implements IDebtEditMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// localView
		//-----------------------------
		
		public function get localView():DebtDetails
		{
			return view as DebtDetails;
		}
		
		//-----------------------------
		// debt
		//-----------------------------
		
		override public function get debt():DebtVO
		{
			return localView.data as DebtVO;
		}
		
		override public function set debt(value:DebtVO):void
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
		
		/**
		 * 
		 * 
		 */		
		override public function populate():void
		{
			super.populate();
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
		protected function confirmation_closeHandler(event:DeleteConfirmEvent):void
		{
			if( event.type == DeleteConfirmEvent.YES )
			{
				dispatch( new DebtEvent( DebtEvent.DELETE, debt ) );
				dispatch( new DebtEvent( DebtEvent.EDIT_BACK ) );
			}
		}
		
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
	}
}