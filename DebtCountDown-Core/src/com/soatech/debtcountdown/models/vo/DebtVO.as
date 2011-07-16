package com.soatech.debtcountdown.models.vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class DebtVO extends EventDispatcher
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var pid:int;
		
		public var planId:int;
		
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
			
			dispatchEvent( new Event( "nameChanged" ) );
		}

		public var bank:String;
		public var balance:Number;
		public var apr:Number;
		public var dueDate:Date;
		public var minPayment:Number;
		
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------

		public function DebtVO()
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
			
			if( item.hasOwnProperty('planId') )
				this.planId = int(item['planId']);
			
			if( item.hasOwnProperty('name') )
				this.name = item['name'];
			
			if( item.hasOwnProperty('bank') )
				this.bank = item['bank'];
			
			if( item.hasOwnProperty('balance') )
				this.balance = Number(item['balance']);
			
			if( item.hasOwnProperty('apr') )
				this.apr = Number(item['apr']);
			
			if( item.hasOwnProperty('dueDate') )
				this.dueDate = new Date(Date.parse(item['dueDate']));
			
			if( item.hasOwnProperty('minPayment') )
				this.minPayment = Number(item['minPayment']);
		}
	}
}