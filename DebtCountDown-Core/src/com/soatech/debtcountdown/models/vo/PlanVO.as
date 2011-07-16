package com.soatech.debtcountdown.models.vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class PlanVO extends EventDispatcher
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// deleting
		//-----------------------------
		// HACK: So we don't dispatch events if delete is click
		public var deleting:Boolean;
		
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
		
		//-----------------------------
		// startDate
		//-----------------------------
		
		public var startDate:Date;

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
		public function PlanVO()
		{
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		public function loadFromDb(item:Object):void
		{
			if( item.hasOwnProperty('pid') )
				this.pid = int(item['pid']);
			
			if( item.hasOwnProperty('name') )
				this.name = item['name'];
			
			if( item.hasOwnProperty('startDate') )
				this.startDate = new Date(Date.parse( item['startDate'] ) );
			
			if( item.hasOwnProperty('expenses') )
				this.expenses = Number(item['expenses']);
			
			if( item.hasOwnProperty('income') )
				this.income = Number(item['income']);
		}
	}
}