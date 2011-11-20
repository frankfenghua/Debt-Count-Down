package com.soatech.debtcountdown.db
{
	import com.soatech.debtcountdown.enum.QueryTypes;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLStatement;
	import flash.data.SQLTransactionLockType;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	
	import org.robotlegs.mvcs.Actor;
	
	public class DBI extends Actor
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
		
		//-----------------------------
		// results
		//-----------------------------
		
		public var results:Array;
		
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
		public var con:SQLConnection;
		
		/**
		 * @private 
		 */		
		protected var connectionCloseResponder:IResponder;
		
		/**
		 * @private 
		 */		
		protected var connectionResponder:IResponder;
		
		/**
		 * @private 
		 */		
		protected var currentQuery:Query;
		
		/**
		 * Default location of the DB
		 * @private 
		 */		
		protected const DEFAULT_LOCATION:String = 'DebtCountDown';
		
		/**
		 * @private 
		 */		
		private var deleteFileResponder:IResponder;
		
		/**
		 * Raw byte array of the pass phrase
		 * @private 
		 */		
		protected var encryptionKey:ByteArray;
		
		/**
		 *@private 
		 */		
		protected var queryStack:Vector.<Query>;
		
		/**
		 * Reference to the SQL statement object
		 * @private
		 */
		protected var stmt:SQLStatement;
		
		/**
		 * @private
		 */		
		protected var stmtResponder:IResponder;
		
		/**
		 * @private 
		 */
		protected var transactionResponder:IResponder;
		
		/**
		 * @private 
		 */		
		protected var transactionStack:Vector.<IResponder>;
		
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * Sets up the data store references.  If a data store does not exist,
		 * it runs the installer.
		 */
		public function DBI(con:SQLConnection=null, location:String=null, file:File = null, 
							encrypted:Boolean=false, encryptionKey:ByteArray=null)
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
			else
				db = File.applicationStorageDirectory.resolvePath(location);
			
			if( con )
			{
				this.con = con;
				stmt = new SQLStatement();
				stmt.sqlConnection = con;
			}
			
			this.encrypted = encrypted;
			this.encryptionKey = encryptionKey;
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param query
		 * 
		 */		
		public function addQuery(query:Query):void
		{
			if( !queryStack )
				queryStack = new Vector.<Query>();
			
			queryStack.push(query);
		}
		
		/**
		 * 
		 * 
		 */		
		public function clearTransactions():void
		{
			transactionResponder = null;
			transactionStack = new Vector.<IResponder>();
		}
		
		/**
		 * Closes the DB location 
		 */		
		public function closeConnection(onResponse:Function, onFault:Function):void
		{
			if( con )
			{
				connectionCloseResponder = new Responder(onResponse, onFault);
				con.addEventListener(SQLEvent.CLOSE, onConnectionClose);
				con.addEventListener(SQLErrorEvent.ERROR, onConnectionCloseFail);
				// calling it directly can cause the app to crash in some situations
				// even a slight delay seems to resolve this.
				setTimeout(function():void{ con.close() }, 2000);
			}
		}
		
		/**
		 * Finalizes a transactions
		 */
		public function commit(onResult:Function, onFault:Function):void
		{
			transactionResponder = new Responder(onResult, onFault);
			con.addEventListener(SQLErrorEvent.ERROR, commit_errorHandler);
			con.addEventListener(SQLEvent.COMMIT, con_commitHandler);
			con.commit();
		}
		
		/**
		 * After deleting all entries in the DB, this will free up the file system space 
		 * 
		 */		
		public function compact():void
		{
			if(!con.inTransaction && !stmt.executing)
				con.compact();
		}
		
		/**
		 * Connects to the DB 
		 */		
		public function connect(onConnectionResult:Function=null, 
								onConnectionFault:Function=null):void
		{
			connectionResponder = new Responder(onConnectionResult, onConnectionFault);
			
			var firstTime:Boolean;
			
			if (!db.exists)
				firstTime = true;
			
			con = new SQLConnection();
			con.addEventListener(SQLErrorEvent.ERROR, con_openErrorHandler);
			con.addEventListener(SQLEvent.OPEN, con_openHandler);
			
			// generate encryption
			if( encrypted && encryptionKey )
			{
				con.openAsync(db, SQLMode.CREATE, null, false, 1024, encryptionKey);
			}
			else
			{
				con.openAsync(db, SQLMode.CREATE);
			}
		}
		
		/**
		 * 
		 * 
		 */		
		protected function execute():void
		{
			if( queryStack && queryStack.length )
				currentQuery = queryStack.shift();
			else
				currentQuery = null;
			
			if( currentQuery )
			{
				query(currentQuery.sql, currentQuery.params);
			}
			else
			{
				stmtResponder.result([]);
			}
		}
		
		/**
		 * Runs a query against the database and rolls it back if there is an error 
		 * @param sql
		 * @param params
		 * @param commit
		 * 
		 */		
		protected function query(sql:String, params:Array = null):void
		{
			stmt.text = sql;
			
			if(!params)
				params = [];
			
			setParameters(params);
			stmt.execute();
		}
		
		/**
		 * Rollbacks a transaction
		 */
		public function rollback():void
		{
			if(con.inTransaction)
			{
				con.addEventListener(SQLEvent.ROLLBACK, con_rollbackHandler);
				con.rollback();
			}
		}
		
		/**
		 * 
		 * 
		 */		
		public function run(onResult:Function, onFault:Function):void
		{
			results = [];
			
			stmtResponder = new Responder(onResult, onFault);
			
			if( !stmt.hasEventListener(SQLEvent.RESULT) )
				stmt.addEventListener(SQLEvent.RESULT, stmt_resultHandler);
			
			if( !stmt.hasEventListener(SQLErrorEvent.ERROR) )
				stmt.addEventListener(SQLErrorEvent.ERROR, stmt_errorHandler);
			
			execute();
		}
		
		/**
		 * 
		 * 
		 */		
		protected function runTransaction():void
		{
			if( transactionStack && transactionStack.length )
			{
				con.addEventListener(SQLErrorEvent.ERROR, tran_ErrorHandler);
				
				con.addEventListener(SQLEvent.BEGIN, con_beginHandler);
				
				transactionResponder = transactionStack.shift();
				
				// for some reason this is happening too fast, so events aren't firing correctly
				if( con.connected ) 
					con.begin(SQLTransactionLockType.IMMEDIATE);
//					setTimeout(function ():void { con.begin(SQLTransactionLockType.IMMEDIATE); }, 2000);
			}
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
		public function startTransaction(onResult:Function, onFault:Function):void
		{
			if( !transactionStack )
				transactionStack = new Vector.<IResponder>();
			
			transactionStack.push(new Responder(onResult, onFault));
			
			if( !transactionResponder )
				runTransaction();
		}
		
		//---------------------------------------------------------------------
		//
		// Result Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function onConnectionClose(event:SQLEvent):void
		{
			con.removeEventListener(SQLEvent.CLOSE, onConnectionClose);
			con.removeEventListener(SQLErrorEvent.ERROR, onConnectionCloseFail);
			connectionCloseResponder.result(this);
		}
		
		//---------------------------------------------------------------------
		//
		// Fault Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function onConnectionCloseFail(event:SQLErrorEvent):void
		{
			con.removeEventListener(SQLEvent.CLOSE, onConnectionClose);
			con.removeEventListener(SQLErrorEvent.ERROR, onConnectionCloseFail);
			connectionCloseResponder.fault(event);
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
		protected function commit_errorHandler(event:SQLErrorEvent):void
		{
			con.removeEventListener(SQLEvent.COMMIT, con_commitHandler);
			con.removeEventListener(SQLErrorEvent.ERROR, commit_errorHandler);
			
			if( transactionResponder )
			{
				transactionResponder.fault(event);
			}
			
			transactionResponder = null;
			runTransaction();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function con_beginHandler(event:SQLEvent):void
		{
			con.removeEventListener(SQLErrorEvent.ERROR, tran_ErrorHandler);
			con.removeEventListener(SQLEvent.BEGIN, con_beginHandler);
			
			if( transactionResponder )
			{
				transactionResponder.result(this);
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function con_commitHandler(event:SQLEvent):void
		{
			con.removeEventListener(SQLErrorEvent.ERROR, commit_errorHandler);
			con.removeEventListener(SQLEvent.COMMIT, con_commitHandler);
			transactionResponder.result(this);
			
			// run the next transaction in the stack
			results = [];
			currentQuery = null;
			transactionResponder = null;
			runTransaction();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function con_openErrorHandler(event:SQLErrorEvent):void
		{
			con.removeEventListener(SQLEvent.OPEN, con_openHandler);
			con.removeEventListener(SQLErrorEvent.ERROR, con_openErrorHandler);
			
			connectionResponder.fault(event);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function con_openHandler(event:SQLEvent):void
		{
			con.removeEventListener(SQLErrorEvent.ERROR, con_openErrorHandler);
			con.removeEventListener(SQLEvent.OPEN, con_openHandler);
			stmt = new SQLStatement();
			stmt.sqlConnection = con;
			
			connectionResponder.result(this);
			connectionResponder = null;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function con_rollbackHandler(event:SQLEvent):void
		{
			con.removeEventListener(SQLEvent.ROLLBACK, con_rollbackHandler);
			queryStack = new Vector.<Query>();
			
			stmtResponder.fault(event);
//			stmtResponder = null;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function stmt_errorHandler(event:SQLErrorEvent):void
		{
			stmtResponder.fault(event);
//			stmtResponder = null;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function stmt_resultHandler(event:SQLEvent):void
		{
			if( currentQuery )
			{
				switch( currentQuery.type )
				{
					case QueryTypes.DELETE:
					case QueryTypes.UPDATE:
						results.push(con.totalChanges);
						break;
					case QueryTypes.INSERT:
						results.push(con.lastInsertRowID);
						break;
					case QueryTypes.SELECT:
						results.push(stmt.getResult().data);
						break;
				}
			}
			
			if( queryStack.length )
			{
				execute();
			}
			else
			{
				queryStack = new Vector.<Query>();
				
				stmtResponder.result(results);
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function tran_ErrorHandler(event:SQLErrorEvent):void
		{
			con.removeEventListener(SQLErrorEvent.ERROR, tran_ErrorHandler);
			con.removeEventListener(SQLEvent.BEGIN, con_beginHandler);
			
			if( transactionResponder )
			{
				transactionResponder.fault(event);
			}
			
			transactionResponder = null;
			runTransaction();
		}
	}
}