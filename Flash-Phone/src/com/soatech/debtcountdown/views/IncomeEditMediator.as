package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.DeleteConfirmEvent;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.views.components.DeleteConfirm;
	import com.soatech.debtcountdown.views.components.IncomeEdit;
	import com.soatech.debtcountdown.views.interfaces.IIncomeEditMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	public class IncomeEditMediator extends IncomeEditMediatorBase implements IMediator, IIncomeEditMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// incomeItem
		//-----------------------------
		
		override public function get incomeItem():BudgetItemVO
		{
			return localView.data as BudgetItemVO;
		}
		
		override public function set incomeItem(value:BudgetItemVO):void
		{
			localView.data = value;
		}
		
		//-----------------------------
		// localView
		//-----------------------------
		
		public function get localView():IncomeEdit
		{
			return view as IncomeEdit;
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
			deleteConfirm.removeEventListener( DeleteConfirmEvent.NO, confirmation_closeHandler );
			deleteConfirm.removeEventListener( DeleteConfirmEvent.YES, confirmation_closeHandler );
			
			if( event.type == DeleteConfirmEvent.YES )
			{
				dispatch( new BudgetEvent( BudgetEvent.DELETE, incomeItem ) );
				dispatch( new BudgetEvent( BudgetEvent.EDIT_BACK ) );
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