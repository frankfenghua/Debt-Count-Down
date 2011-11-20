package com.soatech.debtcountdown.models.vo
{
	public class BudgetItemVO
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var pid:int;
		public var name:String;
		public var amount:Number;
		public var active:Boolean;
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
								 active:Boolean=true, type:String=null)
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
				this.active = Boolean(item['active']);
			
			if( item.hasOwnProperty('type') )
				this.type = item['type'];
		}
	}
}