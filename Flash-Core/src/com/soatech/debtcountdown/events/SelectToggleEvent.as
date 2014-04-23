package com.soatech.debtcountdown.events
{
	import flash.events.Event;
	
	public class SelectToggleEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const EDIT:String = "SELECT_TOGGLE_EDIT";
		public static const TOGGLE:String = "SELECT_TOGGLE_TOGGLE";
		
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// data
		//-----------------------------
		
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
		public function SelectToggleEvent(type:String, data:Object=null, 
										  bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
			this.data = data;
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
			return new SelectToggleEvent( type, data, bubbles, cancelable );
		}
	}
}