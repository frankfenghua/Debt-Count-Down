package com.soatech.debtcountdown.events
{
	import flash.events.Event;
	
	public class PayloadEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		/**
		 * Contextual data for the event 
		 */
		public var data:Object;

		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param type
		 * @param data
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function PayloadEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = data;
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
			return new PayloadEvent(type, data, bubbles, cancelable);
		}
	}
}