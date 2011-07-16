package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	import spark.events.IndexChangeEvent;
	
	public interface IPlanEditMediator extends IMediator
	{
		function get view():IPlanEdit;
		function get plan():PlanVO;
		function populate():void;
		function setup():void;
		function validateAll():Boolean;
		function backBtn_clickHandler(event:MouseEvent):void;
		function debtAddBtn_clickHandler(event:MouseEvent):void;
		function debtList_changeHandler(event:IndexChangeEvent):void;
		function debt_listChangedHandler(event:DebtEvent):void;
		function plan_createSuccessHandler(event:PlanEvent):void;
		function plan_saveSuccessHandler(event:PlanEvent):void;
		function plan_selectedChangedHandler(event:PlanEvent):void;
		function runBtn_clickHandler(event:MouseEvent):void;
		function saveBtn_clickHandler(event:MouseEvent):void;
		
	}
}