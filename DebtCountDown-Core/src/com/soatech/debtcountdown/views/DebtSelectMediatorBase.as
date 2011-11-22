package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.interfaces.IDebtSelect;
	import com.soatech.debtcountdown.views.interfaces.IDebtSelectMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class DebtSelectMediatorBase extends Mediator implements IDebtSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// plan
		//-----------------------------
		
		public function get plan():PlanVO
		{
			return null;
		}
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IDebtSelect
		{
			return viewComponent as IDebtSelect;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// context events
			addContextListener(DebtEvent.LIST_CHANGED, debtList_changeHandler );
			
			// view events
			eventMap.mapListener(view.addBtn, MouseEvent.CLICK, addBtn_clickHandler);
			eventMap.mapListener(view.backBtn, MouseEvent.CLICK, backBtn_clickHandler);
			eventMap.mapListener(view.contBtn, MouseEvent.CLICK, contBtn_clickHandler);
//			eventMap.mapListener(view.debtList, IndexChangeEvent.CHANGE, debtList_selectHandler);
			
			setup();
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
		public function setup():void
		{
			dispatch( new DebtEvent( DebtEvent.LOAD_ALL ) );
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
		public function addBtn_clickHandler(event:MouseEvent):void
		{
			var debt:DebtVO = new DebtVO();
			
			if( plan )
				debt.planId = plan.pid;
			
			dispatch( new DebtEvent( DebtEvent.SELECT, debt ) );
			dispatch( new DebtEvent( DebtEvent.NEW_DEBT, debt ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new DebtEvent( DebtEvent.SELECT_BACK ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function contBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new DebtEvent( DebtEvent.SELECT_CONTINUE, null, null, plan ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function debtList_changeHandler(event:DebtEvent):void
		{
			if( event.debtList.length )
			{
				view.contBtn.enabled = true;
				view.instructions.visible = false;
			}
			else
			{
				view.contBtn.enabled = false;
				view.instructions.visible = true;
			}
			
			view.debtList.dataProvider = event.debtList;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function debtList_selectHandler(event:IndexChangeEvent):void
		{
			var debt:DebtVO = view.debtList.selectedItem as DebtVO;
			
			if( debt )
			{
				/*if( plan )
				{
					// if we passed in a plan, then instead of editing, we want to assign it to the plan
					dispatch( new PlanEvent( PlanEvent.LINK_DEBT, plan, null, debt ) );
					dispatch( new DebtEvent( DebtEvent.SELECT_BACK ) );
				}
				else
				{*/
					dispatch( new DebtEvent( DebtEvent.SELECT, debt ) );
					dispatch( new DebtEvent( DebtEvent.EDIT, debt ) );
//				}
			}
		}
	}
}