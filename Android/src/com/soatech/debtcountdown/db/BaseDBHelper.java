package com.soatech.debtcountdown.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class BaseDBHelper extends SQLiteOpenHelper {

	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------
	
	protected static final String DATABASE_NAME = "dcd-data";
	
	protected static final int DATABASE_VERSION = 3;
	
	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------

	/**
	 * 
	 * @param context
	 */
	public BaseDBHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
	}

	//-------------------------------------------------------------------------
	//
	// Overridden Methods
	//
	//-------------------------------------------------------------------------
		
	@Override
	public void onCreate(SQLiteDatabase db) 
	{
		DebtTable.onCreate(db);
		PlanDebtsTable.onCreate(db);
		PlanTable.onCreate(db);
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) 
	{
		DebtTable.onUpgrade(db, oldVersion, newVersion);
		PlanDebtsTable.onUpgrade(db, oldVersion, newVersion);
		PlanTable.onUpgrade(db, oldVersion, newVersion);
	}

}
