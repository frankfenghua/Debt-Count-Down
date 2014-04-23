package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.db.DBI;
	import com.soatech.debtcountdown.db.Query;
	import com.soatech.debtcountdown.enum.BudgetItemTypes;
	import com.soatech.debtcountdown.enum.QueryTypes;
	import com.soatech.debtcountdown.models.DataBaseProxy;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
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
		
		private const SQL_SELECT_PLAN_DEBTS:String = "SELECT d.pid, name, bank, " +
			"balance, apr, dueDate, paymentRate FROM debts d " +
			"INNER JOIN planDebts pd ON pd.debtId = d.pid AND pd.planId = :planId";
		
		/*private const SQL_SELECT_PLAN_BUDGET_SUM:String = "SELECT SUM(i.amount) AS income, " +
			"SUM(e.amount) AS expenses " +
			"FROM budgetItems i " +
			"LEFT JOIN budgetItems e ON e.type = :expenseType " +
			"WHERE i.type = :incomeType";*/
		
		private const SQL_SELECT_PLAN_BUDGET_SUM:String = "SELECT SUM(i.amount) as income, " +
			"SUM(e.amount) AS expenses " +
			"FROM planBudgetItems pbi " +
			"LEFT JOIN budgetItems e ON e.pid = pbi.budgetItemId AND e.type = :expenseType " +
			"LEFT JOIN budgetItems i ON i.pid = pbi.budgetItemId AND i.type = :incomeType " +
			"WHERE pbi.planId = :planId";
		
		private const SQL_INSERT:String = "INSERT INTO plans (expenses, income, " +
			"name, startDate) VALUES (:expenses, :income, :name, :startDate)";
		
		private const SQL_UPDATE:String = "UPDATE plans SET expenses = :expenses, " +
			"income = :income, name = :name, startDate = :startDate " +
			"WHERE pid = :pid";
		
		private const SQL_DELETE:String = "DELETE FROM plans WHERE pid = :pid";
		
		private const SQL_LINK_BUDGET_ITEM:String = "INSERT INTO planBudgetItems " +
			"(planId, budgetItemId) VALUES (:planId, :budgetItemId)";
		
		private const SQL_LINK_DEBT:String = "INSERT INTO planDebts (planId, debtId) " +
			"VALUES (:planId, :debtId)";
		
		private const SQL_UNLINK_BUDGET_ITEM:String = "DELETE FROM planBudgetItems " +
			"WHERE planId = :planId AND budgetItemId = :budgetItemId";
		
		private const SQL_UNLINK_DEBT:String = "DELETE FROM planDebts " +
			"WHERE planId = :planId AND debtId = :debtId";
		
		private const SQL_SELECT_BUDGET_ITEM:String = "SELECT pid FROM planBudgetItems " +
			"WHERE planId = :planId AND budgetItemId = :budgetItemId";
		
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
		protected var budgetItem:BudgetItemVO;
		
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
			
			dbProxy.applicationDb.startTransaction(onCreateTransactionResult, faultHandler);
		}
		
		/**
		 * 
		 * @param plan
		 * @param budgetItem
		 * @param responder
		 * 
		 */
		public function linkBudgetItem(plan:PlanVO, budgetItem:BudgetItemVO, responder:IResponder):void
		{
			this.plan = plan;
			this.budgetItem = budgetItem;
			this.responder = responder;
			
			var db:DBI = new DBI(dbProxy.applicationDb.con);
			db.addQuery( new Query( SQL_SELECT_BUDGET_ITEM, QueryTypes.SELECT, [plan.pid, budgetItem.pid] ) );
			db.run(linkBudgetItem_selectHandler, faultHandler);
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
			db.run(onLinkDebtSelectResult, faultHandler);
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
			db.run(onLoadRunResult, faultHandler);
		}
		
		/**
		 * 
		 * @param plan
		 * @param responder
		 * 
		 */
		public function loadFullPlan(plan:PlanVO, responder:IResponder):void
		{
			this.plan = plan;
			this.responder = responder;
			
			var db:DBI = new DBI(dbProxy.applicationDb.con);
			db.addQuery( new Query( SQL_SELECT_PLAN_DEBTS, QueryTypes.SELECT, [plan.pid] ) );
			db.addQuery( new Query( SQL_SELECT_PLAN_BUDGET_SUM, QueryTypes.SELECT, 
				[ BudgetItemTypes.EXPENSE, BudgetItemTypes.INCOME, plan.pid ] ) );
			db.run(loadFullPlan_runResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function loadFullPlan_runResult(data:Object):void
		{
			var debtResult:Array = data[0];
			var sumResult:Array = data[1];
			
			plan.debtList = new ArrayCollection();
			
			if( debtResult )
			{
				for each( var item:Object in debtResult )
				{
					plan.debtList.addItem( DebtVO.createFromObject(item) );
				}
			}
			
			if( sumResult )
			{
				plan.expenses = Number(sumResult[0]['expenses']);
				plan.income = Number(sumResult[0]['income']);
			}
			
			responder.result(plan);
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
			
			dbProxy.applicationDb.startTransaction(onRemoveTransactionResult, faultHandler);
		}
		
		/**
		 * 
		 * @param plan
		 * @param budgetItem
		 * @param responder
		 * 
		 */
		public function unlinkBudgetItem(plan:PlanVO, budgetItem:BudgetItemVO, responder:IResponder):void
		{
			this.plan = plan;
			this.budgetItem = budgetItem;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(unlinkBudgetItem_transactionHandler, faultHandler);
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
			
			dbProxy.applicationDb.startTransaction(onUnlinkDebtTransactionResult, faultHandler);
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
			
			dbProxy.applicationDb.startTransaction(onUpdateTransactionResult, faultHandler);
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
		private function linkBudgetItem_commitHandler(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function linkBudgetItem_linkHandler(data:Object):void
		{
			dbProxy.applicationDb.commit(linkBudgetItem_commitHandler, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function linkBudgetItem_selectHandler(data:Object):void
		{
			var result:Array = data[0];
			
			if( !result )
			{
				dbProxy.applicationDb.startTransaction(linkBudgetItem_transactionHandler, faultHandler);
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
		private function linkBudgetItem_transactionHandler(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_LINK_BUDGET_ITEM, QueryTypes.INSERT, [plan.pid, budgetItem.pid] ) );
			dbProxy.applicationDb.run(linkBudgetItem_linkHandler, faultHandler);
		}
		
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
			
			dbProxy.applicationDb.commit(onCreateCommitResult, faultHandler);
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
			dbProxy.applicationDb.run(onCreateRunResult, faultHandler);
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
			dbProxy.applicationDb.commit(onLinkDebtCommitResult, faultHandler);
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
				dbProxy.applicationDb.startTransaction(onLinkDebtTransactionResult, faultHandler);
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
			dbProxy.applicationDb.run(onLinkDebtInsertResult, faultHandler);
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
					plan.loadFromObject(item);
					
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
			dbProxy.applicationDb.commit(onRemoveCommitResult, faultHandler);
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
			dbProxy.applicationDb.run(onRemoveRunResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onRunResult(data:Object):void
		{
			dbProxy.applicationDb.commit(onCommitResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onUnlinkDebtTransactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_UNLINK_DEBT, QueryTypes.DELETE, [plan.pid, debt.pid] ) );
			dbProxy.applicationDb.run(onRunResult, faultHandler);
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
			dbProxy.applicationDb.run(onRunResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function unlinkBudgetItem_commitHandler(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function unlinkBudgetItem_deleteHandler(data:Object):void
		{
			dbProxy.applicationDb.commit(unlinkBudgetItem_commitHandler, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function unlinkBudgetItem_transactionHandler(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_UNLINK_BUDGET_ITEM, QueryTypes.DELETE, [plan.pid, budgetItem.pid] ) );
			dbProxy.applicationDb.run(unlinkBudgetItem_deleteHandler, faultHandler);
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
		private function faultHandler(info:Object):void
		{
			responder.fault(info);
		}
	}
}