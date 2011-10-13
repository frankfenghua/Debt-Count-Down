package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.db.DBI;
	import com.soatech.debtcountdown.db.Query;
	import com.soatech.debtcountdown.enum.QueryTypes;
	import com.soatech.debtcountdown.models.DataBaseProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class PlanService implements IPlanService
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
		// Variables
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 */
		protected var debt:DebtVO;
		
		/**
		 * @private 
		 */
		protected var plan:PlanVO;
		
		/**
		 * @private 
		 */
		protected var responder:IResponder;
		
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
		public function create(plan:PlanVO, responder:IResponder):void
		{
			this.plan = plan;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(onCreateTransactionResult, onFail);
		}
		
		/**
		 * 
		 * @param plan
		 * @param debt
		 * 
		 */		
		public function linkDebt(plan:PlanVO, debt:DebtVO, responder:IResponder):void
		{
			this.plan = plan;
			this.debt = debt;
			this.responder = responder;
			
			var db:DBI = new DBI(dbProxy.applicationDb.con);
			db.addQuery( new Query( SQL_SELECT_DEBT, QueryTypes.SELECT, [plan.pid, debt.pid] ) );
			db.run(onLinkDebtSelectResult, onFail);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function load(responder:IResponder):void
		{
			this.responder = responder;
			
			var db:DBI = new DBI(dbProxy.applicationDb.con);
			db.addQuery( new Query( SQL_SELECT_ALL, QueryTypes.SELECT ) );
			db.run(onLoadRunResult, onFail);
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function remove(plan:PlanVO, responder:IResponder):void
		{
			this.plan = plan;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(onRemoveTransactionResult, onFail);
		}
		
		/**
		 * 
		 * @param plan
		 * @param debt
		 * 
		 */		
		public function unlinkDebt(plan:PlanVO, debt:DebtVO, responder:IResponder):void
		{
			this.debt = debt;
			this.plan = plan;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(onUnlinkDebtTransactionResult, onFail);
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function update(plan:PlanVO, responder:IResponder):void
		{
			this.plan = plan;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(onUpdateTransactionResult, onFail);
		}
		
		//---------------------------------------------------------------------
		//
		// Result Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onCommitResult(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onCreateCommitResult(data:Object):void
		{
			responder.result(plan);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onCreateRunResult(data:Object):void
		{
			plan.pid = int(data[0]);
			
			dbProxy.applicationDb.commit(onCreateCommitResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onCreateTransactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_INSERT, QueryTypes.INSERT, [plan.expenses, 
				plan.income, plan.name, ""] ) );
			dbProxy.applicationDb.run(onCreateRunResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onLinkDebtCommitResult(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		private function onLinkDebtInsertResult(info:Object):void
		{
			dbProxy.applicationDb.commit(onLinkDebtCommitResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onLinkDebtSelectResult(data:Object):void
		{
			var result:Array = data[0];
			
			if( !result )
			{
				dbProxy.applicationDb.startTransaction(onLinkDebtTransactionResult, onFail);
			}
			else
			{
				responder.result(null);
			}
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onLinkDebtTransactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_LINK_DEBT, QueryTypes.INSERT, [plan.pid, debt.pid] ) );
			dbProxy.applicationDb.run(onLinkDebtInsertResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onLoadRunResult(data:Object):void
		{
			var result:Array = data[0];
			var list:ArrayCollection = new ArrayCollection();
			var item:Object;
			var plan:PlanVO;
			
			if( result )
			{
				for each( item in result )
				{
					plan = new PlanVO();
					plan.loadFromDb(item);
					
					list.addItem(plan);
				}
			}
			
			responder.result(list);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onRemoveCommitResult(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onRemoveRunResult(data:Object):void
		{
			dbProxy.applicationDb.commit(onRemoveCommitResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onRemoveTransactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_UNLINK_PLAN, QueryTypes.DELETE, [plan.pid] ) );
			dbProxy.applicationDb.addQuery( new Query( SQL_DELETE, QueryTypes.DELETE, [plan.pid] ) );
			dbProxy.applicationDb.run(onRemoveRunResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onRunResult(data:Object):void
		{
			dbProxy.applicationDb.commit(onCommitResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onUnlinkDebtTransactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_UNLINK_DEBT, QueryTypes.DELETE, [plan.pid, debt.pid] ) );
			dbProxy.applicationDb.run(onRunResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onUpdateTransactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query(SQL_UPDATE, QueryTypes.UPDATE, [plan.expenses, 
				plan.income, plan.name, "", 
				plan.pid] ) );
			dbProxy.applicationDb.run(onRunResult, onFail);
		}
		
		//---------------------------------------------------------------------
		//
		// Fault Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param info
		 * 
		 */
		private function onFail(info:Object):void
		{
			responder.fault(info);
		}
	}
}