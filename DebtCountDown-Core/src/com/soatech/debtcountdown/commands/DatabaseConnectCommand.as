package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.db.DBI;
	import com.soatech.debtcountdown.db.Migrator;
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
		public var dbProxy:DataBaseProxy;

		[Inject]
		public var event:DataBaseEvent;
		
		[Inject]
		public var elsHelper:ELSHelper;
		
		[Inject]
		public var migrator:Migrator;
		
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
			
			if( elsHelper.isSupported && 0 )
			{
				CONFIG::debugtrace{ trace("ELS Supported"); }
				key = elsHelper.getEncryptedKey(dbProxy.APPLICATION_KEY_ELS_ID);
			
				dbProxy.applicationKey = key;
				db = new DBI(null, null, null, true, key);
			}
			else
			{
				CONFIG::debugtrace{ trace("ELS NOT Supported"); }
				db = new DBI(null, null, null, false, null);
			}
			
			dbProxy.applicationDb = db;
			db.connect(onConnectionResult, onConnectionFail);
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param event
		 * 
		 */
		private function onMigrationComplete(event:MigrationEvent):void
		{
			migrator.eventDispatcher.removeEventListener(MigrationEvent.MIGRATION_COMPLETE, onMigrationComplete);
			
			dispatch( new DataBaseEvent( DataBaseEvent.CONNECTED ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Result Handlers
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param data
		 * 
		 */
		public function onConnectionResult(data:Object):void
		{
			migrator.eventDispatcher.addEventListener(MigrationEvent.MIGRATION_COMPLETE, onMigrationComplete);
			migrator.migrations = dbProxy.applicationMigrations;
			migrator.db = dbProxy.applicationDb;
			migrator.migrateTo();
		}
		
		//---------------------------------------------------------------------
		//
		// Fault Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param info
		 * 
		 */
		private function onConnectionFail(info:Object):void
		{
			CONFIG::debugtrace{ trace("DatabaseConnectCommand::onConnectionFail - " + info.toString()); }
		}
	}
}