package com.soatech.debtcountdown.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class FrequencyEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const LIST_CHANGED:String = 'FREQUENCY_LIST_CHANGED';
		public static const LOAD_ALL:String = 'FREQUENCY_LOAD_ALL';

		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// freqList
		//-----------------------------
		
		public var freqList:ArrayCollection;

		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		public function FrequencyEvent(type:String, freqList:ArrayCollection=null, 
									   bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.freqList = freqList;
			
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
			return new FrequencyEvent(type, freqList, bubbles, cancelable);
		}
	}
}