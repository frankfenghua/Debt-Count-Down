package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DatePickerEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.DeleteConfirmEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.components.DebtDetails;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.components.DeleteConfirm;
	import com.soatech.debtcountdown.views.components.DropDownList;
	import com.soatech.debtcountdown.views.components.PlanDetails;
	import com.soatech.debtcountdown.views.components.RunPlan;
	import com.soatech.debtcountdown.views.interfaces.IPlanEditMediator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.events.ResizeEvent;
	import mx.validators.Validator;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class PlanDetailsMedaitor extends PlanEditMediatorBase implements IPlanEditMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// localView
		//-----------------------------
		
		public function get localView():PlanDetails
		{
			return viewComponent as PlanDetails;
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
		 * 
		 */		
		override public function onRegister():void
		{
			super.onRegister();
			
			localView.addEventListener(ResizeEvent.RESIZE, resizeHandler);
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
		 * @param event
		 * 
		 */		
		protected function resizeHandler(event:ResizeEvent):void
		{
			if( localView.width > localView.height )
			{
				localView.debtList.minHeight = localView.height / 2;
			}
			else
			{
				localView.debtList.minHeight = localView.height / 3;
			}
		}
	}
}