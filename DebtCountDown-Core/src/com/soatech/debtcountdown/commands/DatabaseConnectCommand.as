package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.db.DBI;
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.MigrationEvent;
	import com.soatech.debtcountdown.helpers.ELSHelper;
	import com.soatech.debtcountdown.models.DataBaseProxy;
	
	import flash.data.EncryptedLocalStore;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import mx.resources.ResourceManager;
	
	import org.robotlegs.mvcs.Command;
	
	public class DatabaseConnectCommand extends Command
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var event:DataBaseEvent;
		
		[Inject]
		public var dbProxy:DataBaseProxy;
		
		[Inject]
		public var elsHelper:ELSHelper;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override public function execute():void
		{
			var db:DBI;
			var key:ByteArray;
			
			try
			{
				if( elsHelper.isSupported && 0 )
				{
					trace("ELS Supported");
					key = elsHelper.getEncryptedKey(dbProxy.APPLICATION_KEY_ELS_ID);
				
					dbProxy.applicationKey = key;
					db = new DBI(null, null, true, key);
				}
				else
				{
					trace("ELS NOT Supported");
					db = new DBI();
				}
				
				dbProxy.applicationDb = db;
				
				dispatch( new MigrationEvent( MigrationEvent.RUN, db ) );
			}
			catch( e:Error )
			{
				trace("DatabaseConnectCommand::Error: " + e.toString());
			}
		}
	}
}