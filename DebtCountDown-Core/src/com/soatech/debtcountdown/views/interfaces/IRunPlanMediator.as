package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	public interface IRunPlanMediator extends IMediator
	{
		function get view():IRunPlan;
		function get plan():PlanVO;
		function set plan(value:PlanVO):void;
		function setup():void;
		function backBtn_clickHandler(event:MouseEvent):void;
		function plan_runCompleteHandler(event:PaymentPlanEvent):void;
	}
}