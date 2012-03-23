package com.soatech.debtcountdown.db;

import com.soatech.debtcountdown.model.vo.PlanVO;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

public class PlanDbAdapter {

	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
	
	public static final String KEY_ROWID = "_id";
	public static final String KEY_NAME = "name";

	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------
	
	private static final String DB_TABLE = "plans";
	private Context context;
	private SQLiteDatabase db;
	private BaseDBHelper dbHelper;
	
	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------
	
	public PlanDbAdapter(Context context) {
		this.context = context;
	}

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 * @return
	 * @throws SQLException
	 */
	public PlanDbAdapter open() throws SQLException {
		dbHelper = new BaseDBHelper(context);
		db = dbHelper.getWritableDatabase();
		return this;
	}
	
	/**
	 * 
	 */
	public void close() {
		dbHelper.close();
	}
	
	/**
	 * 
	 * @param plan
	 * @return
	 */
	public long createPlan(PlanVO plan) {
		ContentValues values = createContentValues(plan);
		
		return db.insert(DB_TABLE, null, values);
	}
	
	/**
	 * 
	 * @param plan
	 * @return
	 */
	public boolean updatePlan(PlanVO plan) {
		ContentValues values = createContentValues(plan);
		
		return db.update(DB_TABLE, values, KEY_ROWID + " = ?", new String[] { Long.toString(plan._id) }) > 0;
	}
	
	/**
	 * 
	 * @param plan
	 * @return
	 */
	public boolean deletePlan(Long _id) {
		return db.delete(DB_TABLE, KEY_ROWID + " = ?", new String[]{ Long.toString(_id) }) > 0;
	}
	
	/**
	 * 
	 * @return
	 */
	public Cursor fetchAllPlans() {
		return db.query(DB_TABLE, new String[] { KEY_ROWID, KEY_NAME }, null, null, null, null, null);
	}
	
	/**
	 * 
	 * @param pid
	 * @return
	 */
	public Cursor fetchPlan(Long _id) {
		Cursor mCursor = db.query(DB_TABLE, new String[] { KEY_ROWID, KEY_NAME }, KEY_ROWID + "=?", new String[]{ Long.toString(_id) }, null, null, null);
		
		if( mCursor != null ) {
			mCursor.moveToFirst();
		}
		
		return mCursor;
	}

	/**
	 * 
	 * @param name
	 * @return
	 */
	private ContentValues createContentValues(PlanVO plan) {
		ContentValues values = new ContentValues();
		values.put(KEY_NAME, plan.name);
		
		return values;
	}
}
