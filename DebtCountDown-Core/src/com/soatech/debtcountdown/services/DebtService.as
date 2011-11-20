package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.db.DBI;
	import com.soatech.debtcountdown.db.Query;
	import com.soatech.debtcountdown.enum.QueryTypes;
	import com.soatech.debtcountdown.models.DataBaseProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

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
			"balance, apr, dueDate, paymentRate FROM debts";
		
		private const SQL_SELECT_BY_PLAN:String = "SELECT d.pid, name, bank, " +
			"balance, apr, dueDate, paymentRate " +
			"FROM debts d " +
			"INNER JOIN planDebts pd ON pd.debtId = d.pid " +
			"AND pd.planId = :planId";
		
		private const SQL_INSERT:String = "INSERT INTO debts (name, bank, " +
			"balance, apr, dueDate, paymentRate) VALUES (:name, :bank, " +
			":balance, :apr, :dueDate, :paymentRate)";
		
		private const SQL_UPDATE:String = "UPDATE debts SET " +
			"name = :name, bank = :bank, balance = :balance, apr = :apr, dueDate = :dueDate, " +
			"paymentRate = :paymentRate WHERE pid = :pid";
		
		private const SQL_DELETE:String = "DELETE FROM debts WHERE pid = :pid";
		
		private const SQL_UNLINK_DEBT:String = "DELETE FROM planDebts " +
			"WHERE debtId = :debtId";
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------

		/**
		 * @private 
		 */
		private var responder:IResponder;

		/**
		 * @private 
		 */
		private var debt:DebtVO;
		
		
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
		 * @param responder
		 * 
		 */
		public function create(debt:DebtVO, responder:IResponder):void
		{
			this.debt = debt;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(onCreateTransactionStart, onFail);
		}
		
		/**
		 * 
		 * @param responder
		 * 
		 */
		public function loadAll(responder:IResponder):void
		{
			this.responder = responder;
			
			var db:DBI = new DBI(dbProxy.applicationDb.con);
			db.addQuery( new Query( SQL_SELECT_ALL, QueryTypes.SELECT ) );
			db.run(onLoadAllRunResult, onFail);
		}
		
		/**
		 * 
		 * @param planId
		 * @param responder
		 * 
		 */
		public function loadByPlan(planId:int, responder:IResponder):void
		{
			this.responder = responder;
			
			var db:DBI = new DBI(dbProxy.applicationDb.con);
			db.addQuery( new Query( SQL_SELECT_BY_PLAN, QueryTypes.SELECT, [planId] ) );
			db.run(onLoadByPlanRunResult, onFail);
		}
		
		/**
		 * 
		 * @param debt
		 * @param responder
		 * 
		 */
		public function remove(debt:DebtVO, responder:IResponder):void
		{
			this.debt = debt;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(onRemoveTransactionResult, onFail);
		}
		
		/**
		 * 
		 * @param debt
		 * @param responder
		 * 
		 */
		public function update(debt:DebtVO, responder:IResponder):void
		{
			this.debt = debt;
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
		private function onCreateCommitResult(data:Object):void
		{
			responder.result(debt);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onCreateRunResult(data:Object):void
		{
			debt.pid = int(data[0]);
			
			dbProxy.applicationDb.commit(onCreateCommitResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onCreateTransactionStart(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query(SQL_INSERT, QueryTypes.INSERT, [ 
				debt.name, debt.bank, debt.balance, debt.apr, 
				"", debt.paymentRate
			] ) );
			
			dbProxy.applicationDb.run(onCreateRunResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onLoadAllRunResult(data:Object):void
		{
			var result:Array = data[0];
			var list:ArrayCollection = new ArrayCollection();
			var item:Object;
			var debt:DebtVO;
			
			if( result )
			{
				for each( item in result )
				{
					debt = new DebtVO();
					debt.loadFromObject(item);
					
					list.addItem(debt);
				}
			}
			
			responder.result(list);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onLoadByPlanRunResult(data:Object):void
		{
			var result:Array = data[0];
			var list:ArrayCollection = new ArrayCollection();
			var item:Object;
			var debt:DebtVO;
			
			if( result )
			{
				for each( item in result )
				{
					debt = new DebtVO();
					debt.loadFromObject(item);
					
					list.addItem(debt);
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
			dbProxy.applicationDb.addQuery( new Query( SQL_DELETE, QueryTypes.DELETE, [debt.pid] ) );
			dbProxy.applicationDb.addQuery( new Query( SQL_UNLINK_DEBT, QueryTypes.DELETE, [debt.pid] ) );
			dbProxy.applicationDb.run(onRemoveRunResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onUpdateCommitResult(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onUpdateRunResult(data:Object):void
		{
			dbProxy.applicationDb.commit(onUpdateCommitResult, onFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onUpdateTransactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_UPDATE, QueryTypes.UPDATE, [ 
				debt.name, debt.bank, debt.balance, debt.apr, 
				"", debt.paymentRate, debt.pid] ) );
			dbProxy.applicationDb.run(onUpdateRunResult, onFail);
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