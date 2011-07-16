package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.models.DataBaseProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;

	public class DebtService implements IDebtService
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var dbProxy:DataBaseProxy;
		
		//---------------------------------------------------------------------
		//
		// SQL
		//
		//---------------------------------------------------------------------

		private const SQL_SELECT_ALL:String = "SELECT pid, name, bank, " +
			"balance, apr, dueDate, minPayment FROM debts";
		
		private const SQL_SELECT_BY_PLAN:String = "SELECT d.pid, name, bank, " +
			"balance, apr, dueDate, minPayment " +
			"FROM debts d " +
			"INNER JOIN planDebts pd ON pd.debtId = d.pid " +
			"AND pd.planId = :planId";
		
		private const SQL_INSERT:String = "INSERT INTO debts (name, bank, " +
			"balance, apr, dueDate, minPayment) VALUES (:name, :bank, " +
			":balance, :apr, :dueDate, :minPayment)";
		
		private const SQL_UPDATE:String = "UPDATE debts SET " +
			"name = :name, bank = :bank, balance = :balance, apr = :apr, dueDate = :dueDate, " +
			"minPayment = :minPayment WHERE pid = :pid";
		
		private const SQL_DELETE:String = "DELETE FROM debts WHERE pid = :pid";
		
		private const SQL_UNLINK_DEBT:String = "DELETE FROM planDebts " +
			"WHERE debtId = :debtId";
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		public function DebtService()
		{
		}

		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param debt
		 * @return 
		 * 
		 */		
		public function create(debt:DebtVO):DebtVO
		{
			try
			{
				debt.pid = dbProxy.applicationDb.insert( SQL_INSERT, [ 
					debt.name, debt.bank, debt.balance, debt.apr, 
					"", debt.minPayment
				] );
			}
			catch( e:SQLError )
			{
				trace("DebtService::Create - " + e.toString());
			}
			
			return debt;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function loadAll():ArrayCollection
		{
			var result:Array;
			var list:ArrayCollection = new ArrayCollection();
			var item:Object;
			var debt:DebtVO;
			
			try
			{
				result = dbProxy.applicationDb.select( SQL_SELECT_ALL );
				
				if( result )
				{
					for each( item in result )
					{
						debt = new DebtVO();
						debt.loadFromDb(item);
						
						list.addItem(debt);
					}
				}
			}
			catch( e:SQLError )
			{
				trace("DebtService::LoadAll - " + e.toString());
			}
			
			return list;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function loadByPlan(planId:int):ArrayCollection
		{
			var result:Array;
			var list:ArrayCollection = new ArrayCollection();
			var item:Object;
			var debt:DebtVO;
			
			try
			{
				result = dbProxy.applicationDb.select( SQL_SELECT_BY_PLAN, [planId] );
				
				if( result )
				{
					for each( item in result )
					{
						debt = new DebtVO();
						debt.loadFromDb(item);
						
						list.addItem(debt);
					}
				}
			}
			catch( e:SQLError )
			{
				trace("DebtService::LoadByPlan - " + e.toString());
			}
			
			return list;
		}
		
		/**
		 * 
		 * @param debt
		 * 
		 */		
		public function remove(debt:DebtVO):void
		{
			try
			{
				dbProxy.applicationDb.startTransaction();
				
				dbProxy.applicationDb.del( SQL_DELETE, [debt.pid], false );
				
				dbProxy.applicationDb.del( SQL_UNLINK_DEBT, [debt.pid], false );
				
				dbProxy.applicationDb.commit();
			}
			catch( e:SQLError )
			{
				trace("DebtService::Remove - " + e.toString());
			}
		}
		
		/**
		 * 
		 * @param debt
		 * 
		 */		
		public function update(debt:DebtVO):void
		{
			try
			{
				dbProxy.applicationDb.update( SQL_UPDATE, [ 
					debt.name, debt.bank, debt.balance, debt.apr, 
					"", debt.minPayment, debt.pid] );
			}
			catch( e:SQLError )
			{
				trace("DebtService::Update - " + e.toString());
			}
		}
	}
}