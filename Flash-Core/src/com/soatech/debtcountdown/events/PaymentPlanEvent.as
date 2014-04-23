package com.soatech.debtcountdown.events
{
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import flash.events.Event;
	
	public class PaymentPlanEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public static const DETAILS:String = "PAYMENT_PLAN_DETAILS";
		public static const BACK:String = "PAYMENT_PLAN_BACK";
		public static const RUN:String = "PAYMENT_PLAN_RUN";
		public static const RUN_COMPLETE:String = "PAYMENT_PLAN_RUN_COMPLETE";
		public static const SHOW_RUN:String = "PAYMENT_PLAN_SHOW_RUN";
		
		//-----------------------------
		// routine
		//-----------------------------
		
		public var routine:String;
		
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
		 * @param routine
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function PaymentPlanEvent(type:String, routine:String=null, plan:PlanVO=null,
										 bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.plan = plan;
			this.routine = routine;
			
			super(type, bubbles, cancelable);
		}
	}
}