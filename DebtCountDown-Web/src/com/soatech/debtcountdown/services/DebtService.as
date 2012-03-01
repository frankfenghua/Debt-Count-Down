package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.enum.ServiceInfo;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class DebtService implements IDebtService
	{
		//---------------------------------------------------------------------
		//
		//  Properties
		//
		//---------------------------------------------------------------------

		[Inject]
		public var planProxy:PlanProxy;
		
		//---------------------------------------------------------------------
		//
		//  Variables
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
		public function DebtService()
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
		 * @param debt
		 * @param responder
		 * 
		 */
		public function create(debt:DebtVO, responder:IResponder):void
		{
			this.debt = debt;
			this.responder = responder;
			
			service.method = "POST";
			var token:AsyncToken = service.send({
				service:'Debt', 
				action:'AddDebt', 
				'debt[pid]':debt.pid,
				'debt[name]':debt.name,
				'debt[bank]':debt.bank,
				'debt[balance]':debt.balance,
				'debt[apr]':debt.apr,
				'debt[paymentRate]':debt.paymentRate,
				'debt[active]':debt.active,
				planId: planProxy.selectedPlan.pid
			});
			token.addResponder(new Responder(create_resultHandler, faultHandler));
		}
		
		/**
		 * 
		 * @param responder
		 * 
		 */
		public function loadAll(responder:IResponder):void
		{
			
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
			
			service.method = "GET";
			var token:AsyncToken = service.send({
				service:'Debt',
				action:'loadAllDebts',
				planId:planProxy.selectedPlan.pid
			});
			token.addResponder(new Responder(loadByPlan_resultHandler, faultHandler));
		}
		
		/**
		 * 
		 * @param debt
		 * @param responder
		 * 
		 */
		public function remove(debt:DebtVO, responder:IResponder):void
		{
			this.responder = responder;
			
			service.method = "POST";
			var token:AsyncToken = service.send({
				service:'Debt',
				action:'deleteDebt',
				pid:debt.pid,
				planId:planProxy.selectedPlan.pid
			});
			
			token.addResponder(new Responder(remove_resultHandler, faultHandler));
		}
		
		/**
		 * 
		 * @param debt
		 * @param responder
		 * 
		 */
		public function update(debt:DebtVO, responder:IResponder):void
		{
			this.responder = responder;
			
			service.method = "POST";
			var token:AsyncToken = service.send({
				service:'Debt',
				action:'updateDebt',
				'debt[pid]':debt.pid,
				'debt[name]':debt.name,
				'debt[bank]':debt.bank,
				'debt[balance]':debt.balance,
				'debt[apr]':debt.apr,
				'debt[paymentRate]':debt.paymentRate,
				'debt[active]':debt.active,
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
			
			debt.pid = int(JSON.parse(result.result.toString())['pid']);
			
			responder.result(debt);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function loadByPlan_resultHandler(data:Object):void
		{
			var result:ResultEvent = data as ResultEvent;
			var debts:Array = JSON.parse(result.result.toString()) as Array;
			var list:ArrayCollection = new ArrayCollection();
			var debt:DebtVO;
			var item:Object;
			
			if( debts && debts.length )
			{
				for each ( item in debts )
				{
					debt = DebtVO.createFromObject(item);
					
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