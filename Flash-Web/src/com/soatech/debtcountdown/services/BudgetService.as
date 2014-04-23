package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.enum.ServiceInfo;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.services.interfaces.IBudgetService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class BudgetService implements IBudgetService
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------

		[Inject]
		public var planProxy:PlanProxy;
		
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
		private var item:BudgetItemVO;
		
		/**
		 * @private 
		 */		
		private var service:HTTPService;
		
		//---------------------------------------------------------------------
		//
		//  Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */
		public function BudgetService()
		{
			service = new HTTPService(ServiceInfo.BASE_URL);
			service.url = 'dcd_server.php';
			service.useProxy = false;
		}
		
		//---------------------------------------------------------------------
		//
		//  Methods
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
			this.item = budgetItem;
			this.responder = responder;
			
			service.method = 'POST';
			var token:AsyncToken = service.send({
				service:'BudgetItem',
				action:'addItem',
				'item[name]':budgetItem.name,
				'item[amount]':budgetItem.amount,
				'item[type]':budgetItem.type,
				'item[active]':budgetItem.active,
				planId:planProxy.selectedPlan.pid
			});
			token.addResponder(new Responder(create_resultHandler, faultHandler));
		}
		
		/**
		 * 
		 * @param plan
		 * @param responder
		 * 
		 */
		public function loadAll(plan:PlanVO, responder:IResponder):void
		{
			this.responder = responder;
			
			service.method = 'GET';
			var token:AsyncToken = service.send({
				service:'BudgetItem',
				action:'loadAllItems',
				planId:planProxy.selectedPlan.pid
			});
			token.addResponder(new Responder(loadAll_resultHandler, faultHandler));
		}
		
		/**
		 * 
		 * @param budgetItem
		 * @param responder
		 * 
		 */
		public function remove(budgetItem:BudgetItemVO, responder:IResponder):void
		{
			this.responder = responder;
			
			service.method = 'POST';
			var token:AsyncToken = service.send({
				service:'BudgetItem',
				action:'deleteItem',
				pid:budgetItem.pid,
				planId:planProxy.selectedPlan.pid
			});
			token.addResponder(new Responder(remove_resultHandler, faultHandler));
		}
		
		/**
		 * 
		 * @param budgetItem
		 * @param responder
		 * 
		 */
		public function update(budgetItem:BudgetItemVO, responder:IResponder):void
		{
			this.responder = responder;
			
			service.method = 'POST';
			var token:AsyncToken = service.send({
				service:'BudgetItem',
				action:'updateItem',
				'item[pid]':budgetItem.pid,
				'item[name]':budgetItem.name,
				'item[amount]':budgetItem.amount,
				'item[type]':budgetItem.type,
				'item[active]':budgetItem.active,
				planId:planProxy.selectedPlan.pid
			});
			token.addResponder(new Responder(update_resultHandler, faultHandler));
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
		private function create_resultHandler(data:Object):void
		{
			var result:ResultEvent = data as ResultEvent;
			
			item.pid = int(JSON.parse(result.result.toString())['pid']);
			
			responder.result(item);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function loadAll_resultHandler(data:Object):void
		{
			var result:ResultEvent = data as ResultEvent;
			var items:Array = JSON.parse(result.result.toString()) as Array;
			var list:ArrayCollection = new ArrayCollection();
			var item:BudgetItemVO;
			var obj:Object;
			
			if( items && items.length )
			{
				for each ( obj in items )
				{
					item = BudgetItemVO.createFromObject(obj);
					
					list.addItem(item);
				}
			}
			
			responder.result(list);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function remove_resultHandler(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function update_resultHandler(data:Object):void
		{
			responder.result(null);
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