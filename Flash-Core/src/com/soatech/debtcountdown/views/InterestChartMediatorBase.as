package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.RoutineType;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.views.interfaces.IDurationChart;
	import com.soatech.debtcountdown.views.interfaces.IInterestChart;
	import com.soatech.debtcountdown.views.interfaces.IInterestChartMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.formatters.CurrencyFormatter;
	
	public class InterestChartMediatorBase extends Mediator implements IInterestChartMediator
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
		
		public function get view():IInterestChart
		{
			return viewComponent as IInterestChart;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var currencyFormatter:CurrencyFormatter;
		
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
			
			currencyFormatter = new CurrencyFormatter();
			currencyFormatter.useCurrencySymbol = true;
			
			adjustBars();
		}
		
		public function adjustBars():void
		{
			var total:Number = 0;
			
			if( !statsProxy.minStats )
				return;
			
			if( statsProxy.minStats.totalInterestPaid > total )
				total = statsProxy.minStats.totalInterestPaid;
			
			if( statsProxy.balanceStats.totalInterestPaid > total )
				total = statsProxy.balanceStats.totalInterestPaid;
			
			if( statsProxy.rateStats.totalInterestPaid > total )
				total = statsProxy.rateStats.totalInterestPaid;
			
			total = total + (total * 0.25);
			
			view.balanceBar.heading = "Balance Focus";
			view.balanceBar.label = currencyFormatter.format(statsProxy.balanceStats.totalInterestPaid);
			view.balanceBar.percent = (statsProxy.balanceStats.totalInterestPaid / total * 100);
			view.minPaymentBar.heading = "Min. Payment Only";
			view.minPaymentBar.label = currencyFormatter.format(statsProxy.minStats.totalInterestPaid);
			view.minPaymentBar.percent = (statsProxy.minStats.totalInterestPaid / total * 100);
			view.rateBar.heading = "Rate Focus";
			view.rateBar.label = currencyFormatter.format(statsProxy.rateStats.totalInterestPaid);
			view.rateBar.percent = (statsProxy.rateStats.totalInterestPaid / total * 100);
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