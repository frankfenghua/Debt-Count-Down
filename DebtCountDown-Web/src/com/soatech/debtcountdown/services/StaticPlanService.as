package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.models.PlanData;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	
	import mx.collections.ArrayCollection;
	
	public class StaticPlanService implements IPlanService
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var planData:PlanData;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		public function StaticPlanService()
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
			var max:int = 0;
			
			for( var i:int = 0; i < planData.plans.length; i++ )
			{
				max = Math.max(max, planData.plans[i].pid);
			}
			
			max++;
			plan.pid = max;
			
			planData.plans.push(plan);
			
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
			var linked:Boolean;
			
			// see if debt is already linked or not
			for each( var item:DebtVO in planData.debts )
			{
				if( item.planId == plan.pid && item.pid == debt.pid )
					linked = true;
			}
			
			if( !linked )
			{
				debt.planId = plan.pid;
				planData.debts.push(debt);
			}
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function load():ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection();
			var plan:PlanVO;
			
			for( var i:int = 0; i < planData.plans.length; i++ )
			{
				plan = new PlanVO();
				plan.loadFromDb( planData.plans[i] );
				list.addItem( plan );
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
			for( var i:int = 0; i < planData.plans.length; i++ )
			{
				if( planData.plans[i].pid == plan.pid )
					planData.plans.splice(i, 1);
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
			for( var i:int = 0; planData.debts.length; i++ )
			{
				if( planData.debts[i].planId == plan.pid )
					planData.debts.splice(i, 1);
			}
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function update(plan:PlanVO):void
		{
			for( var i:int = 0; i < planData.plans.length; i++ )
			{
				if( planData.plans[i].pid == plan.pid )
					planData.plans[i] = plan;
			}
		}
	}
}