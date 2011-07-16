package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.StatsVO;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	import com.soatech.debtcountdown.services.interfaces.IPayOffService;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class PaymentPlanRunCommand extends Command
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
		public var debtService:IDebtService;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function execute():void
		{
			var balanceList:ArrayCollection = debtService.loadByPlan( event.plan.pid );
			var rateList:ArrayCollection = debtService.loadByPlan( event.plan.pid );
			var minList:ArrayCollection = debtService.loadByPlan( event.plan.pid );
			var payment:Number = event.plan.income - event.plan.expenses;
			
			if( payment <= 0 )
			{
				return;
				// throw an error
			}
			
			statsProxy.balanceStats = payOffService.determinePayOffMultipleByBalance(balanceList, payment);
			statsProxy.minStats = payOffService.determinePayOffMinimumOnly(minList);
			statsProxy.rateStats = payOffService.determinePayOffMultipleByRate(rateList, payment);
			
			dispatch( new PaymentPlanEvent( PaymentPlanEvent.RUN_COMPLETE, null, event.plan ) );
		}
	}
}