package com.soatech.debtcountdown.events
{
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		public static const INIT:String = "APP_INIT";
		
		public function AppEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}