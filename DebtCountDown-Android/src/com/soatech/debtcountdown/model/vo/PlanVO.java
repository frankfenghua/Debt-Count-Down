package com.soatech.debtcountdown.model.vo;

import com.soatech.debtcountdown.db.PlanDbAdapter;

import android.database.Cursor;

public class PlanVO 
{
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
	
	public Long _id;
	public String name;

	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------

	/**
	 * 
	 */
	public PlanVO()
	{
		
	}
	
	/**
	 * 
	 * @param _id
	 * @param name
	 */
	public PlanVO(Long _id, String name) 
	{
		this._id = _id;
		this.name = name;
	}
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 * @param cursor
	 */
	public void load(Cursor cursor)
	{
		this._id = cursor.getLong(cursor.getColumnIndexOrThrow(PlanDbAdapter.KEY_ROWID));
		this.name = cursor.getString(cursor.getColumnIndexOrThrow(PlanDbAdapter.KEY_NAME));
	}
}
