package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	import spark.events.IndexChangeEvent;
	
	public interface IDebtSelectMediator extends IMediator
	{
		function get view():IDebtSelect;
		function get plan():PlanVO;
		
		function addBtn_clickHandler(event:MouseEvent):void;
		function backBtn_clickHandler(event:MouseEvent):void;
		function debtList_changeHandler(event:DebtEvent):void;
		function debtList_selectHandler(event:IndexChangeEvent):void;
		function setup():void;
	}
}