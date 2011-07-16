package com.soatech.debtcountdown.db
{
	import flash.errors.SQLError;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;

	public class Migrator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set migrations(value:Vector.<Migration>):void
		{
			_migrations = value;
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
		
		//----------------------------------------------------------------------
		// 
		// Constructor
		//
		//----------------------------------------------------------------------
		
		public function Migrator(dbi:DBI)
		{
			_dbi = dbi;
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
			_currentVersion = getSchemaVersion();
		}
		
		/**
		 * Fetches the currentVersion from the schemaVersion table 
		 * @return 
		 * 
		 */		
		public function getSchemaVersion():int
		{
			var version:int = 0;
			var results:Array
			
			try
			{
				results = _dbi.select(SQL_SELECT_VERSION);
				
				if( results && results.length > 0 )
					version = int( results[0]["currentVersion"] );
			}
			catch( e:SQLError )
			{
				version = 0;
			}
			
			return version;
		}
		
		/**
		 * Runs through the migrations up to the requested version number
		 * If left blank, it will run all migrations 
		 * @param version
		 * 
		 */		
		public function migrateTo(version:int = 0):void
		{
			var migration:Migration;
			var sql:String;
			var bottom:int;
			var top:int;
			var i:int;
			
			try
			{
				determineVersion();
				
				// find the upper limit of migrations
				if( version == 0 )
				{
					version = _migrations[_migrations.length-1].version;
				}
				
				for( i = 0; i < _migrations.length; ++i )
				{
					migration = _migrations[i];

					if(migration.version > _currentVersion && migration.version <= version )
					{
						_dbi.startTransaction();
						for each( sql in migration.upList )
						{
							_dbi.update(sql, [], false);
						}
						_dbi.commit();
						
						// for at least the first version this has to happen after commit
						// so schemaVersion exists
						_dbi.update(SQL_UPDATE_VERSION, [migration.version]);
					}
				}
			}
			catch(sqlError:SQLError)
			{
				_dbi.rollback();
				
				var fault:FaultEvent = new FaultEvent(FaultEvent.FAULT, false, true, new Fault(sqlError.errorID.toString(), sqlError.message, sqlError.details));
				
//				Alert.show(fault.fault.faultDetail, fault.fault.faultString);
			}
			catch( error:Error )
			{
//				Alert.show(error.message);
			}
		}
	}
}