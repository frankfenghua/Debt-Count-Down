package com.soatech.debtcountdown.events
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class DebtEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public static const CREATE:String = "DEBT_CREATE";
		public static const CREATE_SUCCESS:String = "DEBT_CREATE_SUCCESS";
		public static const DELETE:String = "DEBT_DELETE";
		public static const EDIT:String = "DEBT_EDIT";
		public static const EDIT_BACK:String = "DEBT_EDIT_BACK";
		public static const LIST_CHANGED:String = "DEBT_LIST_CHANGED";
		public static const LOAD_ALL:String = "DEBT_LOAD_ALL";
		public static const LOAD_BY_PLAN:String = "DEBT_LOAD_BY_PLAN";
		public static const NEW_BACK:String = "DEBT_NEW_BACK";
		public static const NEW_DEBT:String = "DEBT_NEW_DEBT";
		public static const SAVE:String = "DEBT_SAVE";
		public static const SAVE_SUCCESS:String = "DEBT_SAVE_SUCESS";
		public static const SELECT:String = "DEBT_SELECT";
		public static const SELECT_BACK:String = "DEBT_SELECT_BACK";
		public static const SELECT_CONTINUE:String = "DEBT_SELECT_CONTINUE";
		public static const SELECTED_CHANGED:String = "DEBT_SELECTED_CHANGED";
		public static const SHOW_SELECT:String = "DEBT_SHOW_SELECT";
		
		//-----------------------------
		// debt
		//-----------------------------
		
		public var debt:DebtVO;
		
		//-----------------------------
		// debtList
		//-----------------------------
		
		public var debtList:ArrayCollection;
		
		//-----------------------------
		// plan
		//-----------------------------
		
		public var plan:PlanVO;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param type
		 * @param debt
		 * @param debtList
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function DebtEvent(type:String, debt:DebtVO=null, 
								  debtList:ArrayCollection=null, plan:PlanVO=null, 
								  bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.debt = debt;
			this.debtList = debtList;
			this.plan = plan;
			
			super(type, bubbles, cancelable);
		}

		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function clone():Event
		{
			return new DebtEvent(type, debt, debtList, plan, bubbles, cancelable);
		}
	}
}