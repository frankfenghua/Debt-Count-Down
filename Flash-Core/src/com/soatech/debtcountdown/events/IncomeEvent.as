package com.soatech.debtcountdown.events
{
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class IncomeEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const NEW_INCOME:String = 'INCOME_NEW_INCOME';
		public static const SELECT_CONTINUE:String = 'INCOME_SELECT_CONTINUE';
		
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
		public function IncomeEvent(type:String, budgetItem:BudgetItemVO=null,
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
			return new IncomeEvent( type, budgetItem, bubbles, cancelable );
		}
	}
}