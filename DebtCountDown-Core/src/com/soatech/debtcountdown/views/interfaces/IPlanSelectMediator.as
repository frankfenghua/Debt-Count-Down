package com.soatech.debtcountdown.views.interfaces
{
	import com.soatech.debtcountdown.events.PlanEvent;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	import spark.events.IndexChangeEvent;
	
	public interface IPlanSelectMediator extends IMediator
	{
		function get view():IPlanSelect;
		function addBtn_clickHandler(event:MouseEvent):void;
		function plan_listChangedHandler(event:PlanEvent):void;
		function planList_changeHandler(event:IndexChangeEvent):void;
		function setup():void;
	}
}