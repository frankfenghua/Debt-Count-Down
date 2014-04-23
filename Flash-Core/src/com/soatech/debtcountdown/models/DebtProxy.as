package com.soatech.debtcountdown.models
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Actor;
	
	public class DebtProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// debtList
		//-----------------------------
		
		private var _debtList:ArrayCollection;

		public function get debtList():ArrayCollection
		{
			return _debtList;
		}

		public function set debtList(value:ArrayCollection):void
		{
			_debtList = value;
			
			dispatch( new DebtEvent( DebtEvent.LIST_CHANGED, null, _debtList ) );
		}
		
		//-----------------------------
		// selectedDebt
		//-----------------------------
		
		private var _selectedDebt:DebtVO;

		public function get selectedDebt():DebtVO
		{
			return _selectedDebt;
		}

		public function set selectedDebt(value:DebtVO):void
		{
			_selectedDebt = value;
			
			dispatch( new DebtEvent( DebtEvent.SELECTED_CHANGED, _selectedDebt ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function addDebt(debt:DebtVO):void
		{
			if( !_debtList )
				_debtList = new ArrayCollection();
			
			_debtList.addItem(debt);
			
			dispatch( new DebtEvent( DebtEvent.LIST_CHANGED, null, _debtList ) );
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function removeDebt(debt:DebtVO):void
		{
			if( !_debtList )
				return;
			
			for( var i:int = 0; i < _debtList.length; i++ )
			{
				if( (_debtList.getItemAt(i) as DebtVO).pid == debt.pid )
					_debtList.removeItemAt(i);
			}
			
			dispatch( new DebtEvent( DebtEvent.LIST_CHANGED, null, _debtList ) );
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function replaceDebt(debt:DebtVO):void
		{
			if( !_debtList )
				return;
			
			for( var i:int = 0; i < _debtList.length; i++ )
			{
				if( (_debtList.getItemAt(i) as DebtVO).pid == debt.pid )
					_debtList.setItemAt(debt, i);
			}
			
			dispatch( new DebtEvent( DebtEvent.LIST_CHANGED, null, _debtList ) );
		}
	}
}