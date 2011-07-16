package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.models.DataBaseProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;

	public class PlanService
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
		
		private const SQL_SELECT_ALL:String = "SELECT pid, expenses, income, " +
			"name, startDate FROM plans";
		
		private const SQL_INSERT:String = "INSERT INTO plans (expenses, income, " +
			"name, startDate) VALUES (:expenses, :income, :name, :startDate)";
		
		private const SQL_UPDATE:String = "UPDATE plans SET expenses = :expenses, " +
			"income = :income, name = :name, startDate = :startDate " +
			"WHERE pid = :pid";
		
		private const SQL_DELETE:String = "DELETE FROM plans WHERE pid = :pid";
		
		private const SQL_LINK_DEBT:String = "INSERT INTO planDebts (planId, debtId) " +
			"VALUES (:planId, :debtId)";
		
		private const SQL_UNLINK_DEBT:String = "DELETE FROM planDebts " +
			"WHERE planId = :planId AND debtId = :debtId";
		
		private const SQL_SELECT_DEBT:String = "SELECT pid FROM planDebts " +
			"WHERE planId = :planId AND debtId = :debtId";
		
		private const SQL_UNLINK_PLAN:String = "DELETE FROM planDebts " +
			"WHERE planId = :planId";
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		public function PlanService()
		{
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param plan
		 * @return 
		 * 
		 */		
		public function create(plan:PlanVO):PlanVO
		{
			try
			{
				plan.pid = dbProxy.applicationDb.insert(SQL_INSERT, [plan.expenses, 
					plan.income, plan.name, ""]);
			}
			catch( e:SQLError )
			{
				trace("PlanService::Create - " + e.toString());
			}
			
			return plan;
		}
		
		/**
		 * 
		 * @param plan
		 * @param debt
		 * 
		 */		
		public function linkDebt(plan:PlanVO, debt:DebtVO):void
		{
			var result:Array;
			
			try
			{
				// see if debt is already linked or not
				result = dbProxy.applicationDb.select( SQL_SELECT_DEBT, [plan.pid, debt.pid] );
				
				if( !result )
					dbProxy.applicationDb.insert( SQL_LINK_DEBT, [plan.pid, debt.pid] );
			}
			catch( e:SQLError )
			{
				trace("PlanService::linkDebt - " + e.toString());
			}
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function load():ArrayCollection
		{
			var result:Array;
			var list:ArrayCollection = new ArrayCollection();
			var item:Object;
			var plan:PlanVO;
			
			try
			{
				result = dbProxy.applicationDb.select(SQL_SELECT_ALL);
				
				if( result )
				{
					for each( item in result )
					{
						plan = new PlanVO();
						plan.loadFromDb(item);
						
						list.addItem(plan);
					}
				}
			}
			catch( e:SQLError )
			{
				trace("PlanService::Load - " + e.toString());
			}
			
			return list;
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function remove(plan:PlanVO):void
		{
			try
			{
				dbProxy.applicationDb.startTransaction();
				
				dbProxy.applicationDb.del( SQL_UNLINK_PLAN, [plan.pid], false );
				
				dbProxy.applicationDb.del( SQL_DELETE, [plan.pid], false );
				
				dbProxy.applicationDb.commit();
			}
			catch( e:SQLError )
			{
				trace("PlanService::Remove - " + e.toString());
			}
		}
		
		/**
		 * 
		 * @param plan
		 * @param debt
		 * 
		 */		
		public function unlinkDebt(plan:PlanVO, debt:DebtVO):void
		{
			try
			{
				dbProxy.applicationDb.insert( SQL_UNLINK_DEBT, [plan.pid, debt.pid] );
			}
			catch( e:SQLError )
			{
				trace("PlanService::unlinkDebt - " + e.toString());
			}
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function update(plan:PlanVO):void
		{
			try
			{
				dbProxy.applicationDb.update(SQL_UPDATE, [plan.expenses, 
					plan.income, plan.name, "", 
					plan.pid]);
			}
			catch( e:SQLError )
			{
				trace("PlanService::Update - " + e.toString());
			}
		}
	}
}