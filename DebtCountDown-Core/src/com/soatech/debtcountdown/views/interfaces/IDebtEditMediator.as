package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	import spark.events.TextOperationEvent;
	
	public interface IDebtEditMediator extends IMediator
	{
		function get view():IDebtEdit;
		function get debt():DebtVO;
		function set debt(value:DebtVO):void;
		function populate():void;
		function validateAll():Boolean;
		function setup():void;
		function backBtn_clickHandler(event:MouseEvent):void;
		function balanceTI_changeHandler(event:TextOperationEvent):void;
		function debt_saveSuccessHandler(event:DebtEvent):void;
		function deleteBtn_clickHandler(event:MouseEvent):void;
		function removeFromPlanBtn_clickHandler(event:MouseEvent):void;
		function saveBtn_clickHandler(event:MouseEvent):void;
	}
}