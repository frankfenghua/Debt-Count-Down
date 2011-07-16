package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.RoutineType;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.views.interfaces.IDurationChart;
	import com.soatech.debtcountdown.views.interfaces.IDurationChartMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class DurationChartMediatorBase extends Mediator implements IDurationChartMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var statsProxy:StatsProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IDurationChart
		{
			return viewComponent as IDurationChart;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			view.balanceBar.addEventListener(MouseEvent.CLICK, balanceBar_clickHandler);
			view.rateBar.addEventListener(MouseEvent.CLICK, rateBar_clickHandler);
			
			eventMap.mapListener( eventDispatcher, PaymentPlanEvent.RUN_COMPLETE, paymentPlan_runCompleteHandler);
			
			adjustBars();
		}
		
		public function adjustBars():void
		{
			var total:Number = 0;
			
			if( !statsProxy.minStats )
				return;
			
			if( statsProxy.minStats.monthsToPayOff > total )
				total = statsProxy.minStats.monthsToPayOff;
			
			if( statsProxy.balanceStats.monthsToPayOff > total )
				total = statsProxy.balanceStats.monthsToPayOff;
			
			if( statsProxy.rateStats.monthsToPayOff > total )
				total = statsProxy.rateStats.monthsToPayOff;
			
			total = total + (total * 0.25);
			
			view.balanceBar.heading = "Balance Focus";
			view.balanceBar.label = statsProxy.balanceStats.monthsToPayOff.toString() + " mo.";
			view.balanceBar.percent = (statsProxy.balanceStats.monthsToPayOff / total * 100);
			view.minPaymentBar.heading = "Min. Payment Only";
			view.minPaymentBar.label = statsProxy.minStats.monthsToPayOff.toString() + " mo.";
			view.minPaymentBar.percent = (statsProxy.minStats.monthsToPayOff / total * 100);
			view.rateBar.heading = "Rate Focus";
			view.rateBar.label = statsProxy.rateStats.monthsToPayOff.toString() + " mo.";
			view.rateBar.percent = (statsProxy.rateStats.monthsToPayOff / total * 100);
		}
		
		public function paymentPlan_runCompleteHandler(event:PaymentPlanEvent):void
		{
			adjustBars();
		}
		
		public function rateBar_clickHandler(event:MouseEvent):void
		{
			statsProxy.selectedRoutine = RoutineType.RATE;
			dispatch( new PaymentPlanEvent( PaymentPlanEvent.DETAILS ) );
		}
		
		public function balanceBar_clickHandler(event:MouseEvent):void
		{
			statsProxy.selectedRoutine = RoutineType.BALANCE;
			dispatch( new PaymentPlanEvent( PaymentPlanEvent.DETAILS ) );
		}
	}
}