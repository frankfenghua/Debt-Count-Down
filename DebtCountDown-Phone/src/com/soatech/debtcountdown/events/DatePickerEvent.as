package com.soatech.debtcountdown.events
{
	import flash.events.Event;
	
	public class DatePickerEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public static const DATE_SELECTED:String = "DATE_PICKER_DATE_SELECTED";
		public static const DATE_VALID:String = "DATE_PICKER_DATE_VALID";
		public static const DATE_INVALID:String = "DATE_PICKER_DATE_INVALID";
		public static const DATE_CHANGE:String = "DATE_PICKER_DATE_CHANGE";
		
		//-----------------------------
		// date
		//-----------------------------
		
		public var date:Date;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function DatePickerEvent(type:String, date:Date=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.date = date;
		}
	}
}