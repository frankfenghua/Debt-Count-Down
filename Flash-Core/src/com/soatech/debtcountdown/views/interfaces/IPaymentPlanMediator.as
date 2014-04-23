package com.soatech.debtcountdown.views.interfaces
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	public interface IPaymentPlanMediator extends IMediator
	{
		function get view():IPaymentPlan;
		function setup():void;
		function backBtn_clickHandler(event:MouseEvent):void
	}
}