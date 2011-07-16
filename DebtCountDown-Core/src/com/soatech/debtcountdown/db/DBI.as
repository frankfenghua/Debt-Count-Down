package com.soatech.debtcountdown.db
{
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.data.SQLTransactionLockType;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	public class DBI
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// encryptionPhrase
		//-----------------------------
		
		private var _encryptionPhrase:String;
		
		public function get encryptionPhrase():String
		{
			return _encryptionPhrase;
		}
		
		public function set encryptionPhrase(value:String):void
		{
			_encryptionPhrase = value;
		}
		
		//-----------------------------
		// encrypted
		//-----------------------------
		
		private var _encrypted:Boolean;

		public function get encrypted():Boolean
		{
			return _encrypted;
		}

		public function set encrypted(value:Boolean):void
		{
			_encrypted = value;
		}
		
		//-----------------------------
		// isInTransaction
		//-----------------------------
		
		public function get isInTransaction():Boolean {
			return con.inTransaction;
		}

		//-----------------------------
		// location
		//-----------------------------
		
		private var _location:String;

		public function get location():String
		{
			return _location;
		}

		public function set location(value:String):void
		{
			_location = value;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		/**
		 * File reference to the data store
		 * @private
		 */
		protected var db:File;
		
		/**
		 * Reference to the SQLite connection
		 * @private
		 */
		protected var con:SQLConnection;
		
		/**
		 * Reference to the SQL statement object
		 * @private
		 */
		protected var stmt:SQLStatement;
		
		/**
		 * Raw byte array of the pass phrase
		 * @private 
		 */		
		protected var encryptionKey:ByteArray;
		
		/**
		 * Default location of the DB
		 * @private 
		 */		
		protected const DEFAULT_LOCATION:String = 'DebtCountDown';
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * Sets up the data store references.  If a data store does not exist,
		 * it runs the installer.
		 */
		public function DBI(location:String=null, file:File = null, 
							encrypted:Boolean=false, encryptionKey:ByteArray=null, 
							autoconnect:Boolean=true)
		{
			if( !location )
				location = DEFAULT_LOCATION;
			
			if( encrypted )
				location = location + ".enc.db";
			else
				location = location + ".db";
			
			this.location = location;
			
			if( file )
				db = file;
			
			this.encrypted = encrypted;
			this.encryptionKey = encryptionKey;
			
			if( autoconnect )
				connect();
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Connects to the DB 
		 */		
		private function connect():void
		{
			var firstTime:Boolean;
			
			// New, encrypted DB
			if ( !db )
				db = File.applicationStorageDirectory.resolvePath(location);
			
			if (!db.exists)
				firstTime = true;
			
			con = new SQLConnection();
			
			// generate encryption
			if( encrypted && encryptionKey )
			{
				con.open(db, SQLMode.CREATE, false, 1024, encryptionKey);
			}
			else
			{
				con.open(db, SQLMode.CREATE);
			}
			
			stmt = new SQLStatement();
			stmt.sqlConnection = con;
		}
		
		/**
		 * Assigns parameters to the statement
		 * @private
		 * @param params Array
		 */
		protected function setParameters(params:Array):void
		{
			stmt.clearParameters();
			
			if( !params )
				return;
			
			// set the params
			for(var i:int=0; i < params.length; i++)
			{
				stmt.parameters[i] = params[i];
			}
		}
		
		/**
		 * Start a transaction
		 */
		public function startTransaction():void
		{
			if (!con.inTransaction)
				con.begin(SQLTransactionLockType.IMMEDIATE);
		}
		
		/**
		 * After deleting all entries in the DB, this will free up the file system space 
		 * 
		 */		
		public function compact():void
		{
			con.compact();
		}
		
		/**
		 * Closes the DB location 
		 */		
		public function closeConnection():void
		{
			stmt = null;
			
			if( con )
				con.close();
			
			con = null;
			db = null;
		}
		
		/**
		 * Finalizes a transactions
		 */
		public function commit():void
		{
			if(con.inTransaction)
				con.commit();
		}
		
		/**
		 * Rollbacks a transaction
		 */
		public function rollback():void
		{
			if(con.inTransaction)
				con.rollback();
		}
		
		/**
		 * Runs a query against the database and rolls it back if there is an error 
		 * @param sql
		 * @param params
		 * @param commit
		 * 
		 */		
		public function query(sql:String, params:Array = null, commit:Boolean = true):void
		{
			try
			{
				if (commit)
					startTransaction();
				
				stmt.text = sql;
				
				if(!params)
					params = [];
					
				setParameters(params);
				stmt.execute();
				
				if (commit)
					con.commit();
			}
			catch( e:SQLError )
			{
				this.rollback();
				
				throw e;
			}
		}
		
		/**
		 * Runs a select statement on the database
		 * @param sql String
		 * @param params Array. Parameters to be bound in the SQL statement
		 * @param commit Boolean. Default true. Whether or not to commit after executing statement
		 * @return Array
		 */
		public function select(sql:String, params:Array = null):Array
		{
			stmt.text = sql;
	
			if( !params )
				params = [];
			
			setParameters(params);
			
			stmt.execute();
			
			var result:SQLResult = stmt.getResult();
			
			if( result )
				return result.data;
			else
				return null;
		}
		
		/**
		 * Runs an insert statement on the database
		 * @param sql String
		 * @param params Array. Parameters to be bound in the SQL statement
		 * @param commit Boolean. Default true. Whether or not to commit after executing statement
		 * @return Number Primary Key/ID of the last inserted record
		 */
		public function insert(sql:String, params:Array, commit:Boolean = true):Number
		{
			this.query(sql, params, commit);
			
			return con.lastInsertRowID;
		}
		
		/**
		 * Runs a delete statement on the database
		 * @param sql String
		 * @param params Array. Parameters to be bound in the SQL statement
		 * @param commit Boolean. Default true. Whether or not to commit after executing statement
		 * @return Number How many records were affected
		 */
		public function del(sql:String, params:Array, commit:Boolean = true):Number
		{
			this.query(sql, params, commit);
			
			return con.totalChanges;
		}
		
		/**
		 * Runs an update statement on the database
		 * @param sql String
		 * @param params Array. Parameters to be bound in the SQL statement
		 * @param commit Boolean. Default true. Whether or not to commit after executing statement
		 * @return Number How many records were affected
		 */
		public function update(sql:String, params:Array, commit:Boolean = true):Number
		{
			this.query(sql, params, commit);
			
			return con.totalChanges;
		}
	}
}