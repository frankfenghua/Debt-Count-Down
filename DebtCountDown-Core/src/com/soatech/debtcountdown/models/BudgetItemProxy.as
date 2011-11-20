package com.soatech.debtcountdown.models
{
	import com.soatech.debtcountdown.enum.BudgetItemTypes;
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BudgetItemProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// budgetItemList
		//-----------------------------
		
		private var _budgetItemList:ArrayCollection;
		
		public function get budgetItemList():ArrayCollection
		{
			return _budgetItemList;
		}
		
		public function set budgetItemList(value:ArrayCollection):void
		{
			_budgetItemList = value;
			
			dispatch( new BudgetEvent( BudgetEvent.LIST_CHANGED, null, _budgetItemList ) );
		}
		
		//-----------------------------
		// expenseList
		//-----------------------------
		
		public function get expenseList():ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection(_budgetItemList.source);
			list.filterFunction = expenseList_filterFunction;
			list.refresh();
			
			return list;
		}
		
		//-----------------------------
		// incomeList
		//-----------------------------
		
		public function get incomeList():ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection(_budgetItemList.source);
			list.filterFunction = incomeList_filterFunction;
			list.refresh();
			
			return list;
		}
		
		//-----------------------------
		// selectedItem
		//-----------------------------
		
		public var selectedItem:BudgetItemVO;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */
		public function BudgetItemProxy()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param budgetIem
		 * 
		 */
		public function addBudgetItem(budgetIem:BudgetItemVO):void
		{
			if( !_budgetItemList )
				_budgetItemList = new ArrayCollection();
			
			_budgetItemList.addItem(budgetIem);
			
			dispatch( new BudgetEvent( BudgetEvent.LIST_CHANGED, null, _budgetItemList ) );
		}
		
		/**
		 * 
		 * @param item
		 * @return 
		 * 
		 */
		private function expenseList_filterFunction(item:BudgetItemVO):Boolean
		{
			if( item.type == BudgetItemTypes.EXPENSE )
				return true;
			
			return false;
		}

		/**
		 * 
		 * @param item
		 * @return 
		 * 
		 */
		private function incomeList_filterFunction(item:BudgetItemVO):Boolean
		{
			if( item.type == BudgetItemTypes.INCOME )
				return true;
			
			return false;
		}
		
		/**
		 * 
		 * @param budgetItem
		 * 
		 */
		public function removeBudgetItem(budgetItem:BudgetItemVO):void
		{
			if( !_budgetItemList )
				return;
			
			for( var i:int = 0; i < _budgetItemList.length; i++ )
			{
				if( (_budgetItemList.getItemAt(i) as BudgetItemVO).pid == budgetItem.pid )
					_budgetItemList.removeItemAt(i);
			}
			
			dispatch( new BudgetEvent( BudgetEvent.LIST_CHANGED, null, _budgetItemList ) );
		}
		
		/**
		 * 
		 * @param budgetItem
		 * 
		 */
		public function replaceBudgetItem(budgetItem:BudgetItemVO):void
		{
			if( !_budgetItemList )
				return;
			
			for( var i:int = 0; i < _budgetItemList.length; i++ )
			{
				if( (_budgetItemList.getItemAt(i) as BudgetItemVO).pid == budgetItem.pid )
					_budgetItemList.setItemAt(budgetItem, i);
			}

			dispatch( new BudgetEvent( BudgetEvent.LIST_CHANGED, null, _budgetItemList ) );
		}
	}
}