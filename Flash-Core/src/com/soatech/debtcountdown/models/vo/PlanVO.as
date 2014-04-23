package com.soatech.debtcountdown.models.vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	public class PlanVO extends EventDispatcher
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// debtList
		//-----------------------------
		
		public var debtList:ArrayCollection;
		
		//-----------------------------
		// expenses
		//-----------------------------
		
		public var expenses:Number;
		
		//-----------------------------
		// income
		//-----------------------------
		
		public var income:Number;
		
		//-----------------------------
		// name
		//-----------------------------
		
		private var _name:String;

		[Bindable(event="nameChanged")]
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
			
			dispatchEvent( new Event("nameChanged") );
		}
		
		//-----------------------------
		// pid
		//-----------------------------
		
		public var pid:int;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param pid
		 * @param name
		 * 
		 */		
		public function PlanVO(pid:int=0, name:String=null, expenses:Number=0, income:Number=0)
		{
			this.pid = pid;
			this.name = name;
			this.expenses = expenses;
			this.income = income;
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param item
		 * @return 
		 * 
		 */
		public static function createFromObject(item:Object):PlanVO
		{
			var plan:PlanVO = new PlanVO();
			plan.loadFromObject(item);
			
			return plan;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function clone():PlanVO
		{
			return new PlanVO(pid, name, expenses, income);
		}
		
		/**
		 * 
		 * @param item
		 * 
		 */
		public function loadFromObject(item:Object):void
		{
			if( item.hasOwnProperty('pid') )
				this.pid = int(item['pid']);
			
			if( item.hasOwnProperty('name') )
				this.name = item['name'];
		}
	}
}