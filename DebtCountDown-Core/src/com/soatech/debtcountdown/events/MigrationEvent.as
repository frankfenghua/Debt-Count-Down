package com.soatech.debtcountdown.events
{
	import com.soatech.debtcountdown.db.DBI;
	
	import flash.events.Event;
	
	public class MigrationEvent extends Event
	{
		public static const RUN:String = "MIGRATION_RUN";
		
		public var db:DBI;
		
		public function MigrationEvent(type:String, db:DBI=null, 
									   bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.db = db;
		}
	}
}