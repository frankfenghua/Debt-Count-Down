package com.soatech.debtcountdown.models.vo
{
	public class FrequencyVO
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var pid:int;
		public var type:String;
		public var dateInfo:Date;
		public var dateInfo2:Date;

		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param pid
		 * @param type
		 * @param dateInfo
		 * @param dateInfo2
		 * 
		 */
		public function FrequencyVO(pid:int=0, type:String=null, dateInfo:Date=null, dateInfo2:Date=null)
		{
			this.pid = pid;
			this.type = type;
			this.dateInfo = dateInfo;
			this.dateInfo2 = dateInfo2;
		}

		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function clone():FrequencyVO
		{
			return new FrequencyVO(pid, type, dateInfo, dateInfo2);
		}
		
		/**
		 * 
		 * @param item
		 * @return 
		 * 
		 */
		public static function createFromObject(item:Object):FrequencyVO
		{
			var freq:FrequencyVO = new FrequencyVO();
			freq.loadFromObject(item);
			
			return freq;
		}
		
		/**
		 * 
		 * @param item
		 * 
		 */
		public function loadFromObject(item:Object):void
		{
			if( item.hasOwnProperty('pid') )
				this.pid = item['pid'];
			else if( item.hasOwnProperty('frequency_pid') )
				this.pid = item['frequency_pid'];
			
			if( item.hasOwnProperty('type') )
				this.type = item['type'];
			
			if( item.hasOwnProperty('dateInfo') )
				this.dateInfo = new Date(Date.parse(item['dateInfo']));
			
			if( item.hasOwnProperty('dateInfo2') )
				this.dateInfo2 = new Date(Date.parse(item['dateInfo2']));
		}
	}
}