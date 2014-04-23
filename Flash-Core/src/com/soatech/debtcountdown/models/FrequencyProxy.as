package com.soatech.debtcountdown.models
{
	import com.soatech.debtcountdown.events.FrequencyEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	public class FrequencyProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// freqList
		//-----------------------------
		
		/**
		 * @private 
		 */
		private var _freqList:ArrayCollection;
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get freqList():ArrayCollection
		{
			return _freqList;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set freqList(value:ArrayCollection):void
		{
			_freqList = value;
			
			dispatch( new FrequencyEvent( FrequencyEvent.LIST_CHANGED, _freqList ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */
		public function FrequencyProxy()
		{
			super();
		}
	}
}