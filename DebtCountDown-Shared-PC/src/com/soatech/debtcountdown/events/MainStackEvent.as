package com.soatech.debtcountdown.events
{
	import flash.events.Event;
	
	public class MainStackEvent extends Event
	{
		public static const SWITCH_DEBT_EDIT:String = "MAIN_STACK_SWITCH_DEBT_EDIT";
		public static const SWITCH_DEBT_SELECT:String = "MAIN_STACK_SWITCH_DEBT_SELECT";
		public static const SWITCH_EXPENSE_EDIT:String = "MAIN_STACK_SWITCH_EXPENSE_EDIT";
		public static const SWITCH_EXPENSE_SELECT:String = "MAIN_STACK_SWITCH_EXPENSE_SELECT";
		public static const SWITCH_INCOME_EDIT:String = "MAIN_STACK_SWITCH_INCOME_EDIT";
		public static const SWITCH_INCOME_SELECT:String = "MAIN_STACK_SWITCH_INCOME_SELECT";
		public static const SWITCH_PAYMENT_PLAN:String = "MAIN_STACK_SWITCH_PAYMENT_PLAN";
		public static const SWITCH_PLAN_EDIT:String = "MAIN_STACK_SWITCH_PLAN_EDIT";
		public static const SWITCH_PLAN_SELECT:String = "MAIN_STACK_SWITCH_PLAN_SELECT";
		public static const SWITCH_RUN_PLAN:String = "MAIN_STACK_SWITCH_RUN_PLAN";
		public static const SWITCH_SPLASH:String = "MAIN_STACK_SWITCH_SPLASH";
		
		public function MainStackEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}