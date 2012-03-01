package com.soatech.debtcountdown.db
{
	public class Query
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var sql:String;
		public var params:Array;
		public var type:String;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param sql
		 * @param params
		 * 
		 */		
		public function Query(sql:String, type:String, params:Array=null )
		{
			this.sql = sql;
			this.params = params;
			this.type = type;
		}
	}
}