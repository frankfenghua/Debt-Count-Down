package com.soatech.debtcountdown.db;

import android.database.sqlite.SQLiteDatabase;

public class DebtTable {

	//-------------------------------------------------------------------------
	//
	// SQL
	//
	//-------------------------------------------------------------------------
	
	private static final String CREATE_TABLE = "CREATE TABLE debts (_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, bank TEXT, balance REAL, apr REAL, paymentRate REAL)";
	
	private static final String DROP_TABLE = "DROP TABLE IF EXISTS debts";
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 * @param db
	 */
	public static void onCreate(SQLiteDatabase db)
	{
		db.execSQL(CREATE_TABLE);
	}
	
	/**
	 * 
	 * @param db
	 * @param oldVersion
	 * @param newVersion
	 */
	public static void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion)
	{
		db.execSQL(DROP_TABLE);
		
		onCreate(db);
	}
	
}
