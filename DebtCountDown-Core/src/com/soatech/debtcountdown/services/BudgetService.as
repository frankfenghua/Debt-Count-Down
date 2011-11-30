package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.db.Query;
	import com.soatech.debtcountdown.enum.QueryTypes;
	import com.soatech.debtcountdown.models.DataBaseProxy;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.services.interfaces.IBudgetService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class BudgetService implements IBudgetService
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
		
		protected const SQL_DELETE:String = 'DELETE FROM budgetItems WHERE pid = :pid';
		
		protected const SQL_INSERT:String = "INSERT INTO budgetItems (name, " +
			"amount, type) VALUES (:name, :amount, :type)";

		protected const SQL_SELECT_ALL:String = 'SELECT b.pid, name, amount, type, pb.pid AS active ' +
			'FROM budgetItems b ' +
			'LEFT OUTER JOIN planBudgetItems pb ON pb.budgetItemId = b.pid ' +
			'AND pb.planId = :planId';
		
		protected const SQL_UPDATE:String = "UPDATE budgetItems SET name = :name, " +
			"amount = :amount, type = :type WHERE pid = :pid";

		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------

		/**
		 * @private 
		 */
		private var budgetItem:BudgetItemVO;
		
		/**
		 * @private 
		 */
		private var plan:PlanVO;

		/**
		 * @private 
		 */
		private var responder:IResponder;
		
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param budgetItem
		 * @param responder
		 * 
		 */
		public function create(budgetItem:BudgetItemVO, responder:IResponder):void
		{
			this.budgetItem = budgetItem;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(create_transactionResult, faultHandler);
		}
		
		/**
		 * 
		 * @param responder
		 * @return 
		 * 
		 */
		public function loadAll(plan:PlanVO, responder:IResponder):void
		{
			this.plan = plan;
			this.responder = responder;
			
			dbProxy.applicationDb.addQuery( new Query( SQL_SELECT_ALL, QueryTypes.SELECT, [plan.pid] ) );
			dbProxy.applicationDb.run(loadAll_runResult, faultHandler);
		}
		
		/**
		 * 
		 * @param budgetItem
		 * @param responder
		 * 
		 */
		public function remove(budgetItem:BudgetItemVO, responder:IResponder):void
		{
			this.budgetItem = budgetItem;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(remove_transactionResult, faultHandler);
		}
		
		/**
		 * 
		 * @param budgetItem
		 * @param responder
		 * 
		 */
		public function update(budgetItem:BudgetItemVO, responder:IResponder):void
		{
			this.budgetItem = budgetItem;
			this.responder = responder;
			
			dbProxy.applicationDb.startTransaction(update_transactionResult, faultHandler);
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
		protected function create_commitResult(data:Object):void
		{
			responder.result(budgetItem);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		protected function create_runResult(data:Object):void
		{
			budgetItem.pid = data[0];
			
			dbProxy.applicationDb.commit(create_commitResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		protected function create_transactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_INSERT, QueryTypes.INSERT, 
				[ budgetItem.name, budgetItem.amount, budgetItem.type ] ) );
			
			dbProxy.applicationDb.run(create_runResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		protected function loadAll_runResult(data:Object):void
		{
			var result:Array = data[0];
			var list:ArrayCollection = new ArrayCollection();
			
			if( result )
			{
				for each( var item:Object in result )
					list.addItem( BudgetItemVO.createFromObject( item ) );
			}
			
			responder.result(list);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function remove_commitResult(data:Object):void
		{
			responder.result(budgetItem);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function remove_runResult(data:Object):void
		{
			dbProxy.applicationDb.commit(remove_commitResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function remove_transactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_DELETE, QueryTypes.DELETE, 
				[ budgetItem.pid ] ) );
			dbProxy.applicationDb.run(remove_runResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		protected function update_commitResult(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		protected function update_runResult(data:Object):void
		{
			dbProxy.applicationDb.commit(update_commitResult, faultHandler);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		protected function update_transactionResult(data:Object):void
		{
			dbProxy.applicationDb.addQuery( new Query( SQL_UPDATE, QueryTypes.UPDATE, 
				[ 
					budgetItem.name, budgetItem.amount, budgetItem.type, 
					budgetItem.pid 
				] 
			) );
			
			dbProxy.applicationDb.run(update_runResult, faultHandler);
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