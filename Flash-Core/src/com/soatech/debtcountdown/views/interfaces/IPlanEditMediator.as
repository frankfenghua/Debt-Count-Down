package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	public interface IPlanEditMediator extends IMediator
	{
		function get view():IPlanEdit;
		function get plan():PlanVO;
		function populate():void;
		function setup():void;
		function validateAll():Boolean;
		function backBtn_clickHandler(event:MouseEvent):void;
		function contBtn_clickHandler(event:MouseEvent):void;
		function plan_createSuccessHandler(event:PlanEvent):void;
		function plan_saveSuccessHandler(event:PlanEvent):void;
		function plan_selectedChangedHandler(event:PlanEvent):void;
		function saveBtn_clickHandler(event:MouseEvent):void;
	}
}