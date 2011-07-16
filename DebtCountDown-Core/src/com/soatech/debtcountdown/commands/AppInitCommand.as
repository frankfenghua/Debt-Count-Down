package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.DataBaseEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class AppInitCommand extends Command
	{
		override public function execute():void
		{
			dispatch( new DataBaseEvent( DataBaseEvent.CONNECT ) );
		}
	}
}