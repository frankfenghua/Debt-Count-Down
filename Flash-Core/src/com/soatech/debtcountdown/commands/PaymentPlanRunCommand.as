package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.models.vo.StatsVO;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	import com.soatech.debtcountdown.services.interfaces.IPayOffService;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class PaymentPlanRunCommand extends Command implements IResponder
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var payOffService:IPayOffService;
		
		[Inject]
		public var event:PaymentPlanEvent;
		
		[Inject]
		public var debtProxy:DebtProxy;
		
		[Inject]
		public var statsProxy:StatsProxy;
		
		[Inject]
		public var planService:IPlanService;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function execute():void
		{
			planService.loadFullPlan( event.plan, this );
		}

		//---------------------------------------------------------------------
		//
		// Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function result(data:Object):void
		{
			var plan:PlanVO = data as PlanVO;
			
			// need each list unique, as we are modifying object values
			var balanceList:ArrayCollection = new ArrayCollection();
			var rateList:ArrayCollection = new ArrayCollection();
			var minList:ArrayCollection = new ArrayCollection();
			
			for each( var item:DebtVO in plan.debtList )
			{
				balanceList.addItem(item.clone());
				rateList.addItem(item.clone());
				minList.addItem(item.clone());
			}
			
			var payment:Number = plan.income - plan.expenses;
			
			if( payment <= 0 )
			{
				return;
				// throw an error
			}
			
			statsProxy.balanceStats = payOffService.determinePayOffMultipleByBalance(balanceList, payment);
			statsProxy.minStats = payOffService.determinePayOffMinimumOnly(minList);
			statsProxy.rateStats = payOffService.determinePayOffMultipleByRate(rateList, payment);
			
			dispatch( new PaymentPlanEvent( PaymentPlanEvent.RUN_COMPLETE, null, plan ) );
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("PaymentPlanRunCommand::fault - " + info.toString()); }
		}
	}
}