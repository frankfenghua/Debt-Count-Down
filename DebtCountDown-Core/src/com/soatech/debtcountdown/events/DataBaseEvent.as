package com.soatech.debtcountdown.events
{
	import flash.events.Event;
	
	public class DataBaseEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const CONNECT:String = "DATA_BASE_CONNECT";
		public static const CONNECTED:String = "DATA_BASE_CONNECTED";
		
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
		public function DataBaseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}