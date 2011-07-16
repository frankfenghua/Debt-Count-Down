package com.soatech.debtcountdown.models
{
	import com.soatech.debtcountdown.db.DBI;
	
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Actor;
	
	public class DataBaseProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public const APPLICATION_KEY_ELS_ID:String = "DebtCountDown-ApplicationDb";
		
		//-----------------------------
		// applicationDb
		//-----------------------------
		
		public var applicationDb:DBI;
		
		//-----------------------------
		// applicationKey
		//-----------------------------
		
		public var applicationKey:ByteArray;
	}
}