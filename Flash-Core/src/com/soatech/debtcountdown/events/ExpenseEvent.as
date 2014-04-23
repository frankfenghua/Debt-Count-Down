package com.soatech.debtcountdown.events
{
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	
	import flash.events.Event;
	
	public class ExpenseEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const NEW_EXPENSE:String = 'EXPENSE_NEW_EXPENSE';
		public static const SELECT_CONTINUE:String = 'EXPENSE_SELECT_CONTINUE';
		
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var budgetItem:BudgetItemVO;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param type
		 * @param budgetItem
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function ExpenseEvent(type:String, budgetItem:BudgetItemVO=null,
									 bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.budgetItem = budgetItem;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @return 
		 * 
		 */
		override public function clone():Event
		{
			return new ExpenseEvent( type, budgetItem, bubbles, cancelable );
		}
	}
}