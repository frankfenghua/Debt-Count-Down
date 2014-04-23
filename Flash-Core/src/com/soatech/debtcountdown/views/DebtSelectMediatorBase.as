package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.events.SelectToggleEvent;
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
			eventMap.mapListener( view.debtList, SelectToggleEvent.EDIT, debtList_selectEditHandler );
			eventMap.mapListener( view.debtList, SelectToggleEvent.TOGGLE, debtList_selectToggleHandler );
			
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
			dispatch( new DebtEvent( DebtEvent.LOAD_BY_PLAN ) );
		}
		
		/**
		 * 
		 * 
		 */
		public function verifyToggles():void
		{
			// check to see if any are select
			var enabled:Boolean = false;
			for each( var debt:DebtVO in view.debtList.dataProvider )
			{
				if( debt.active )
					enabled = true;
			}
			
			view.contBtn.enabled = enabled;
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
				view.addInstructions.visible = false;
				view.toggleInstructions.visible = true;
				view.toggleInstructions.includeInLayout = true;
			}
			else
			{
				view.contBtn.enabled = false;
				view.addInstructions.visible = true;
				view.toggleInstructions.visible = false;
				view.toggleInstructions.includeInLayout = false;
			}
			
			view.debtList.dataProvider = event.debtList;
			
			verifyToggles();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function debtList_selectEditHandler(event:SelectToggleEvent):void
		{
			var debt:DebtVO = event.data as DebtVO;
			dispatch( new DebtEvent( DebtEvent.SELECT, debt ) );
			dispatch( new DebtEvent( DebtEvent.EDIT, debt ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		private function debtList_selectToggleHandler(event:SelectToggleEvent):void
		{
			// dispatch event to update the DB and link the debt to the plan
			if( (event.data as DebtVO).active )
				dispatch( new PlanEvent( PlanEvent.LINK_DEBT, null, null, event.data as DebtVO) );
			else
				dispatch( new PlanEvent( PlanEvent.UNLINK_DEBT, null, null, event.data as DebtVO) );
			
			verifyToggles();
		}
	}
}