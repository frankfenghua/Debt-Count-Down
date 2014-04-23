package com.soatech.debtcountdown.db
{
	import com.soatech.debtcountdown.enum.QueryTypes;
	import com.soatech.debtcountdown.events.MigrationEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.robotlegs.mvcs.Actor;

	[Event(name="MIGRATION_COMPLETE", type="com.follett.fsc.reader.events.MigrationEvent")]
	public class Migrator extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public static const NO_DATABASE_EXISTS_DO_COMPLETE_MIGRATION:int = 0;
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set migrations(value:Vector.<Migration>):void
		{
			_migrations = value;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set db(value:DBI):void
		{
			_dbi = value;
		}
		
		//---------------------------------------------------------------------
		//
		// SQL
		//
		//---------------------------------------------------------------------
		
		private const SQL_SELECT_VERSION:String = "SELECT currentVersion FROM schemaVersion";
		private const SQL_UPDATE_VERSION:String = "UPDATE schemaVersion SET currentVersion = ?";
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		protected var _dbi:DBI;
		
		/**
		 * @private 
		 */		
		protected var _migrations:Vector.<Migration>;
		
		/**
		 * @private 
		 */		
		protected var _currentVersion:int;
		
		/**
		 * @private 
		 */		
		private var _requestedVersion:int;
		
		//----------------------------------------------------------------------
		// 
		// Constructor
		//
		//----------------------------------------------------------------------
		
		public function Migrator()
		{
		}
		
		//----------------------------------------------------------------------
		// 
		// Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Checks against the DB to find what version the schema is at
		 * @private
		 */		
		protected function determineVersion():void
		{
			_dbi.addQuery( new Query(SQL_SELECT_VERSION, QueryTypes.SELECT) );
			_dbi.run(onSelectVersionResult, onSelectVersionFault);
		}
		
		/**
		 * Runs through the migrations up to the requested version number
		 * If left blank, it will run all migrations 
		 * @param version
		 * 
		 */		
		public function migrateTo(version:int = 0):void
		{
			_requestedVersion = version;
			
			_dbi.startTransaction(onTransactionStart, onTransactionFail);
		}
		
		//----------------------------------------------------------------------
		// 
		// Result Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onCommit(data:Object):void
		{
			dispatch(new MigrationEvent( MigrationEvent.MIGRATION_COMPLETE ));
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function onMigrationComplete(data:Object):void
		{
			_dbi.commit(onCommit, onCommitFail);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function onSelectVersionResult(data:Object):void
		{
			var migration:Migration;
			var sql:String;
			
			var result:Array = data[0];
			
			if( !result || !result.length )
				_currentVersion = 0;
			else
				_currentVersion = int(result[0]['currentVersion']);
			
			// find the upper limit of migrations
			if( _requestedVersion == NO_DATABASE_EXISTS_DO_COMPLETE_MIGRATION )
			{
				_requestedVersion = _migrations[_migrations.length-1].version;
			}
			
			for( var i:int = 0; i < _migrations.length; ++i )
			{
				migration = _migrations[i];
				
				if(migration.version > _currentVersion && migration.version <= _requestedVersion )
				{
					for each( sql in migration.upList )
					{
						_dbi.addQuery( new Query(sql, QueryTypes.OTHER) );
					}
					_dbi.addQuery( new Query(SQL_UPDATE_VERSION, QueryTypes.UPDATE, [migration.version]) );
				}
			}
			_dbi.run(onMigrationComplete, onMigrationFault);
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		private function onTransactionStart(data:Object):void
		{
			determineVersion();
		}
		
		//----------------------------------------------------------------------
		// 
		// Fault Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * 
		 * @param info
		 * 
		 */
		private function onCommitFail(info:Object):void
		{
			trace("Migrator::onCommitFail " + info.toString());
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		private function onMigrationFault(info:Object):void
		{
			trace("Migrator::onMigrationFault " + info.toString());
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function onSelectVersionFault(info:Object):void
		{
			onSelectVersionResult([[{'currentVersion': 0}]]);
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		private function onTransactionFail(info:Object):void
		{
			trace("Migrator::onTransactionFail " + info.toString());
		}
	}
}