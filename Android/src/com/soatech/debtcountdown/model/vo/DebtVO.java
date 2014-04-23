package com.soatech.debtcountdown.model.vo;

import com.soatech.debtcountdown.db.DebtDbAdapter;

import android.database.Cursor;

public class DebtVO 
{

	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
	
	public Long _id;
	public String name;
	public String bank;
	public Double balance;
	public Double apr;
	public Double paymentRate;
	public boolean active;
	public Long planId;

	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 */
	public DebtVO()
	{
		
	}
	
	/**
	 * 
	 * @param _id
	 * @param name
	 * @param bank
	 * @param balance
	 * @param apr
	 * @param paymentRate
	 */
	public DebtVO(Long _id, String name, String bank, Double balance, Double apr, Double paymentRate, boolean active, Long planId)
	{
		this._id = _id;
		this.name = name;
		this.bank = bank;
		this.balance = balance;
		this.apr = apr;
		this.paymentRate = paymentRate;
		this.active = active;
		this.planId = planId;
	}
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 * @return
	 */
	public Double getMinPayment()
	{
		Double min = this.balance * this.paymentRate;
		
		// make no payment less than $15
		if( min < 15 )
		{
			min = 15.00;
		}
		
		return min;
	}
	
	/**
	 * 
	 * @param cursor
	 */
	public void load(Cursor cursor)
	{
		this._id = cursor.getLong(cursor.getColumnIndexOrThrow(DebtDbAdapter.KEY_ROWID));
		this.name = cursor.getString(cursor.getColumnIndexOrThrow(DebtDbAdapter.KEY_NAME));
		this.bank = cursor.getString(cursor.getColumnIndexOrThrow(DebtDbAdapter.KEY_BANK));
		this.balance = cursor.getDouble(cursor.getColumnIndexOrThrow(DebtDbAdapter.KEY_BALANCE));
		this.apr = cursor.getDouble(cursor.getColumnIndexOrThrow(DebtDbAdapter.KEY_APR));
		this.paymentRate = cursor.getDouble(cursor.getColumnIndexOrThrow(DebtDbAdapter.KEY_PAYMENT_RATE));
		
		if( cursor.isNull(cursor.getColumnIndex(DebtDbAdapter.KEY_ACTIVE)) == false )
			this.active = (cursor.getInt(cursor.getColumnIndexOrThrow(DebtDbAdapter.KEY_ACTIVE)) != 0 ? true : false);
	}
}
