package com.soatech.debtcountdown.db;

import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

public class PlanTable {
	
	//-------------------------------------------------------------------------
	//
	// SQL
	//
	//-------------------------------------------------------------------------
	
//	private static final String CREATE_BACKUP_TABLE = "CREATE TABLE plans_backup AS SELECT * FROM plans";
	
	private static final String CREATE_TABLE = "CREATE TABLE plans (_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";

//	private static final String DROP_BACKUP_TABLE = "DROP TABLE IF EXISTS plans_backup";
	
	private static final String DROP_TABLE = "DROP TABLE IF EXISTS plans";
	
//	private static final String RESTORE_BACKUP = "INSERT INTO plans (_id, name) SELECT _id, name FROM plans_backup";
	
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * 
	 * @param db
	 */
	public static void onCreate(SQLiteDatabase db) {
		db.execSQL(CREATE_TABLE);
	}
	
	/**
	 * 
	 * @param db
	 * @param oldVersion
	 * @param newVersion
	 */
	public static void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		Log.w(PlanTable.class.getName(), "Upgrading database from version " + oldVersion + " to " + newVersion);
		
		// create backup
//		db.execSQL(CREATE_BACKUP_TABLE);
		
		db.execSQL(DROP_TABLE);
		
		onCreate(db);
		
//		db.execSQL(RESTORE_BACKUP);
		
//		db.execSQL(DROP_BACKUP_TABLE);
	}
}
