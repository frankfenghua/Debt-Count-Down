package com.soatech.debtcountdown.models.vo
{
	import com.soatech.debtcountdown.models.interfaces.IToggleAble;

	public class BudgetItemVO implements IToggleAble
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// active
		//-----------------------------
		
		private var _active:Boolean;
		
		public function get active():Boolean
		{
			return _active;
		}
		
		public function set active(value:Boolean):void
		{
			_active = value;
		}
		
		public var amount:Number;
		
		//-----------------------------
		// name
		//-----------------------------
		
		private var _name:String;

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public var pid:int;
		public var type:String;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param pid
		 * @param name
		 * @param amount
		 * @param active
		 * @param frequency
		 * 
		 */
		public function BudgetItemVO(pid:int=0, name:String=null, amount:Number=NaN, 
								 active:Boolean=false, type:String=null)
		{
			this.pid = pid;
			this.name = name;
			this.amount = amount;
			this.active = active;
			this.type = type;
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
		public function clone():BudgetItemVO
		{
			return new BudgetItemVO(pid, name, amount, active, type);
		}
		
		/**
		 * 
		 * @param item
		 * @return 
		 * 
		 */
		public static function createFromObject(item:Object):BudgetItemVO
		{
			var income:BudgetItemVO = new BudgetItemVO();
			income.loadFromObject(item);
			
			return income;
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
			else if( item.hasOwnProperty('income_pid') )
				this.pid = item['income_pid'];
			
			if( item.hasOwnProperty('name') )
				this.name = item['name'];
			
			if( item.hasOwnProperty('amount') )
				this.amount = Number(item['amount']);
			
			if( item.hasOwnProperty('active') )
			{
				if( int(item['active']).toString() == item['active'] )
					this.active = Boolean(item['active']);
				else
					this.active = ((item['active'] == 'true') ? true : false);
			}
			
			if( item.hasOwnProperty('type') )
				this.type = item['type'];
		}
	}
}