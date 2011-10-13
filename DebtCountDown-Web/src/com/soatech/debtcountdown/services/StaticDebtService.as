package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.models.DebtData;
	import com.soatech.debtcountdown.models.PlanData;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class StaticDebtService implements IDebtService
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var debtData:DebtData;
		
		[Inject]
		public var planData:PlanData;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		public function StaticDebtService()
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
		public function create(debt:DebtVO, responder:IResponder):void
		{
			var max:int = 0;
			
			for( var i:int = 0; i < debtData.debts.length; i++ )
			{
				max = Math.max(max, debtData.debts[i].pid);
			}
			
			max++;
			debt.pid = max;
			
			debtData.debts.push(debt);
			
			responder.result(debt);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function loadAll(responder:IResponder):void
		{
			var list:ArrayCollection = new ArrayCollection();
			var debt:DebtVO;
			
			for( var i:int = 0; i < debtData.debts.length; i++ )
			{
				debt = new DebtVO();
				debt.loadFromDb( debtData.debts[i] );
				list.addItem( debt );
			}
			
			responder.result(list);
		}
		
		/**
		 * 
		 * @param planId
		 * @return 
		 * 
		 */		
		public function loadByPlan(planId:int, responder:IResponder):void
		{
			var list:ArrayCollection = new ArrayCollection();
			var debt:DebtVO;
			
			for( var i:int = 0; i < planData.debts.length; i++ )
			{
				if( planData.debts[i].planId == planId )
				{
					debt = new DebtVO();
					debt.loadFromDb( planData.debts[i] );
					list.addItem( debt );
				}
			}
			
			responder.result(list);
		}
		
		/**
		 * 
		 * @param debt
		 * 
		 */		
		public function remove(debt:DebtVO, responder:IResponder):void
		{
			for( var i:int = 0; i < debtData.debts.length; i++ )
			{
				if( debtData.debts[i].pid == debt.pid )
					debtData.debts.splice(i, 1);
			}
			
			responder.result(null);
		}
		
		/**
		 * 
		 * @param debt
		 * 
		 */		
		public function update(debt:DebtVO, responder:IResponder):void
		{
			for( var i:int = 0; i < debtData.debts.length; i++ )
			{
				if( debtData.debts[i].pid == debt.pid )
					debtData.debts[i] = debt;
			}
			
			responder.result(null);
		}
	}
}