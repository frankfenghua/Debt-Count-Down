package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.MigrationEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class AppInitCommand extends Command
	{
		override public function execute():void
		{
			dispatch( new MigrationEvent( MigrationEvent.BUILD ) );
			dispatch( new DataBaseEvent( DataBaseEvent.CONNECT ) );
		}
	}
}