package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	public interface IInterestChartMediator extends IMediator
	{
		function get view():IInterestChart;
		function balanceBar_clickHandler(event:MouseEvent):void;
		function paymentPlan_runCompleteHandler(event:PaymentPlanEvent):void
		function rateBar_clickHandler(event:MouseEvent):void;
		function adjustBars():void;
	}
}