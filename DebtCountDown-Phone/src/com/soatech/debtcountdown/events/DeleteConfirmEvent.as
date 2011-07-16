package com.soatech.debtcountdown.events
{
	import flash.events.Event;
	
	public class DeleteConfirmEvent extends Event
	{
		public static const NO:String = "DELETE_CONFIRM_NO";
		public static const YES:String = "DELETE_CONFIRM_YES";
		
		public function DeleteConfirmEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}