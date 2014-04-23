package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.ExpenseEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.events.SelectToggleEvent;
	import com.soatech.debtcountdown.models.BudgetItemProxy;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.views.interfaces.IExpenseSelect;
	import com.soatech.debtcountdown.views.interfaces.IExpenseSelectMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class ExpenseSelectMediatorBase extends Mediator implements IMediator, IExpenseSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var biProxy:BudgetItemProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IExpenseSelect
		{
			return viewComponent as IExpenseSelect;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
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
			
			// context listeners
			addContextListener( BudgetEvent.LIST_CHANGED, expenseList_changeHandler );
			
			// view listeners
			eventMap.mapListener( view.addBtn, MouseEvent.CLICK, addBtn_clickHandler );
			eventMap.mapListener( view.backBtn, MouseEvent.CLICK, backBtn_clickHandler );
			eventMap.mapListener( view.contBtn, MouseEvent.CLICK, contBtn_clickHandler );
			eventMap.mapListener( view.expenseList, SelectToggleEvent.EDIT, expenseList_selectEditHandler );
			eventMap.mapListener( view.expenseList, SelectToggleEvent.TOGGLE, expenseList_selectToggleHandler );
			
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
			dispatch( new BudgetEvent( BudgetEvent.LOAD_ALL ) );
		}
		
		/**
		 * 
		 * 
		 */
		public function verifyToggles():void
		{
			// check to see if any are select
			var enabled:Boolean = false;
			for each( var item:BudgetItemVO in view.expenseList.dataProvider )
			{
				if( item.active )
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
			var budgetItem:BudgetItemVO = new BudgetItemVO();
			
			dispatch( new BudgetEvent( BudgetEvent.SELECT, budgetItem ) );
			dispatch( new ExpenseEvent( ExpenseEvent.NEW_EXPENSE, budgetItem ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new BudgetEvent( BudgetEvent.SELECT_BACK ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function contBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new ExpenseEvent( ExpenseEvent.SELECT_CONTINUE ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function expenseList_changeHandler(event:BudgetEvent):void
		{
			if( biProxy.expenseList.length )
			{
				view.contBtn.enabled = true;
				view.addInstructions.visible = false;
			}
			else
			{
				view.contBtn.enabled = false;
				view.addInstructions.visible = true;
			}
			
			view.expenseList.dataProvider = biProxy.expenseList;
			
			verifyToggles();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function expenseList_selectEditHandler(event:SelectToggleEvent):void
		{
			var expense:BudgetItemVO = event.data as BudgetItemVO;
			
			dispatch( new BudgetEvent( BudgetEvent.SELECT, expense ) );
			dispatch( new BudgetEvent( BudgetEvent.EDIT, expense ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function expenseList_selectToggleHandler(event:SelectToggleEvent):void
		{
			// dispatch event to update the DB and link the debt to the plan
			if( (event.data as BudgetItemVO).active )
				dispatch( new PlanEvent( PlanEvent.LINK_BUDGET_ITEM, null, null, null, event.data as BudgetItemVO) );
			else
				dispatch( new PlanEvent( PlanEvent.UNLINK_BUDGET_ITEM, null, null, null, event.data as BudgetItemVO) );
			
			verifyToggles();
		}
	}
}