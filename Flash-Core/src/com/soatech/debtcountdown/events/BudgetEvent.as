package com.soatech.debtcountdown.events
{
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class BudgetEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const CREATE:String = 'BUDGET_CREATE';
		public static const CREATE_SUCCESS:String = 'BUDGET_CREATE_SUCCESS';
		public static const DELETE:String = 'BUDGET_DELETE';
		public static const EDIT:String = 'BUDGET_EDIT';
		public static const EDIT_BACK:String = 'BUDGET_EDIT_BACK';
		public static const LIST_CHANGED:String = 'BUDGET_LIST_CHANGED';
		public static const LOAD_ALL:String = 'BUDGET_LOAD_ALL';
		public static const NEW_BACK:String = 'BUDGET_NEW_BACK';
		public static const SAVE:String = 'BUDGET_SAVE';
		public static const SAVE_SUCCESS:String = 'BUDGET_SAVE_SUCCESS';
		public static const SELECT:String = 'BUDGET_SELECT';
		public static const SELECT_BACK:String = 'BUDGET_SELECT_BACK';

		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------

		//-----------------------------
		// budgetItem
		//-----------------------------
		
		public var budgetItem:BudgetItemVO;
		
		//-----------------------------
		// budgetList
		//-----------------------------
		
		public var budgetList:ArrayCollection;
		
		//---------------------------------------------------------------------
		//
		// Constructors
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param type
		 * @param budgetList
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function BudgetEvent(type:String, budgetItem:BudgetItemVO=null, budgetList:ArrayCollection=null, 
									bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.budgetItem = budgetItem;
			this.budgetList = budgetList;
			
			super(type, bubbles, cancelable);
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
			return new BudgetEvent(type, budgetItem, budgetList, bubbles, cancelable);
		}
	}
}