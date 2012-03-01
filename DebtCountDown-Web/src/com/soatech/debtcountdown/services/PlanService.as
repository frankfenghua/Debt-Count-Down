package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.enum.ServiceInfo;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class PlanService implements IPlanService
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------

		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 */
		protected var plan:PlanVO;
		
		/**
		 * @private 
		 */
		protected var responder:IResponder;
		
		/**
		 * @private 
		 */
		protected var service:HTTPService;

		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		public function PlanService()
		{
			service = new HTTPService(ServiceInfo.BASE_URL);
			service.url = 'dcd_server.php';
			service.useProxy = false;
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param plan
		 * @param responder
		 * 
		 */
		public function create(plan:PlanVO, responder:IResponder):void
		{
			this.plan = plan;
			this.responder = responder;
			
			service.method = "POST";
			var token:AsyncToken = service.send({
				service:'Plan',
				action:'addPlan',
				name:plan.name
			});
			token.addResponder(new Responder(create_resultHandler, faultHandler));
		}
		
		public function linkBudgetItem(plan:PlanVO, budgetItem:BudgetItemVO, responder:IResponder):void
		{
		}
		
		public function linkDebt(plan:PlanVO, debt:DebtVO, responder:IResponder):void
		{
		}
		
		/**
		 * 
		 * @param responder
		 * 
		 */
		public function load(responder:IResponder):void
		{
			this.responder = responder;
			
			service.method = "GET";
			var token:AsyncToken = service.send({
				service:'Plan',
				action:'loadAllPlans'
			});
			token.addResponder(new Responder(load_resultHandler, faultHandler));
		}
		
		public function loadFullPlan(plan:PlanVO, responder:IResponder):void
		{
		}
		
		/**
		 * 
		 * @param plan
		 * @param responder
		 * 
		 */
		public function remove(plan:PlanVO, responder:IResponder):void
		{
			this.responder = responder;
			
			service.method = "POST";
			var token:AsyncToken = service.send({
				service:'Plan',
				action:'deletePlan',
				pid:plan.pid
			});
			token.addResponder(new Responder(remove_resultHandler, faultHandler));
		}
		
		public function unlinkBudgetItem(plan:PlanVO, budgetItem:BudgetItemVO, responder:IResponder):void
		{
		}
		
		public function unlinkDebt(plan:PlanVO, debt:DebtVO, responder:IResponder):void
		{
		}
		
		/**
		 * 
		 * @param plan
		 * @param responder
		 * 
		 */
		public function update(plan:PlanVO, responder:IResponder):void
		{
			this.responder = responder;
			
			service.method = 'POST';
			var token:AsyncToken = service.send({
				service:'Plan',
				action:'updatePlan',
				'plan[name]':plan.name,
				'plan[pid]':plan.pid
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
		protected function create_resultHandler(data:Object):void
		{
			var result:ResultEvent = data as ResultEvent;
			
			plan.pid = int(JSON.parse(result.result.toString())['pid']);
			
			responder.result(plan);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		protected function load_resultHandler(data:Object):void
		{
			var result:ResultEvent = data as ResultEvent;
			var plans:Array = JSON.parse(result.result.toString()) as Array;
			var list:ArrayCollection = new ArrayCollection();
			var item:Object;
			var plan:PlanVO;
			
			if( plans && plans.length )
			{
				for each( item in plans )
				{
					plan = PlanVO.createFromObject(item);
					
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
		protected function remove_resultHandler(data:Object):void
		{
			responder.result(null);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		protected function update_resultHandler(data:Object):void
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