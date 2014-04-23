package com.soatech.debtcountdown.events
{
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class PlanEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const CREATE:String = "PLAN_CREATE";
		public static const CREATE_SUCCESS:String = "PLAN_CREATE_SUCCESS";
		public static const DELETE:String = "PLAN_DELETE";
		public static const EDIT:String = "PLAN_EDIT";
		public static const EDIT_BACK:String = "PLAN_EDIT_BACK";
		public static const LOAD:String = "PLAN_LOAD";
		public static const LINK_BUDGET_ITEM:String = "PLAN_LINK_BUDGET_ITEM";
		public static const LINK_DEBT:String = "PLAN_LINK_DEBT";
		public static const LIST_CHANGED:String = "PLAN_LIST_CHANGED";
		public static const NEW_PLAN:String = "PLAN_NEW";
		public static const NEW_BACK:String = "PLAN_NEW_BACK";
		public static const SAVE:String = "PLAN_SAVE";
		public static const SAVE_SUCCESS:String = "PLAN_SAVE_SUCCESS";
		public static const SELECT:String = "PLAN_SELECT";
		public static const SELECTED_CHANGED:String = "PLAN_SELECTED_CHANGED";
		public static const UNLINK_BUDGET_ITEM:String = "PLAN_UNLINK_BUDGET_ITEM";
		public static const UNLINK_DEBT:String = "PLAN_UNLINK_DEBT";
		
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var budgetItem:BudgetItemVO;
		
		//-----------------------------
		// debt
		//-----------------------------
		
		public var debt:DebtVO;
		
		//-----------------------------
		// plan
		//-----------------------------
		
		public var plan:PlanVO;
		
		//-----------------------------
		// planList
		//-----------------------------
		
		public var planList:ArrayCollection;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param type
		 * @param plan
		 * @param planList
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function PlanEvent(type:String, plan:PlanVO=null, planList:ArrayCollection=null, 
								  debt:DebtVO=null, budgetItem:BudgetItemVO=null, 
								  bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.plan = plan;
			this.planList = planList;
			this.debt = debt;
			this.budgetItem = budgetItem;
			
			super(type, bubbles, cancelable);
		}
	}
}