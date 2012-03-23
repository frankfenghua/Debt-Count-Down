package com.soatech.debtcountdown.db;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

import com.soatech.debtcountdown.model.vo.DebtVO;

public class DebtDbAdapter {

	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
	
	public static final String KEY_ROWID = "_id";
	public static final String KEY_NAME = "name";
	public static final String KEY_BANK = "bank";
	public static final String KEY_BALANCE = "balance";
	public static final String KEY_APR = "apr";
	public static final String KEY_PAYMENT_RATE = "paymentRate";
	public static final String KEY_ACTIVE = "active";
	
	//-------------------------------------------------------------------------
	//
	// SQL
	//
	//-------------------------------------------------------------------------

	private static final String SQL_FETCH_ALL_DEBTS = "SELECT d._id, name, bank, " +
			"balance, apr, paymentRate, pd._id AS active " +
			"FROM debts d " +
			"LEFT OUTER JOIN planDebts pd ON pd.debtId = d._id AND pd.planId = ?";
	
	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------
	
	private static final String DB_TABLE = "debts";
	private Context context;
	private SQLiteDatabase db;
	private BaseDBHelper dbHelper;

	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------
	
	public DebtDbAdapter(Context context)
	{
		this.context = context;
	}

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 */
	public void close()
	{
		dbHelper.close();
	}
	
	/**
	 * 
	 * @param debt
	 * @return
	 */
	private ContentValues createContentValues(DebtVO debt)
	{
		ContentValues values = new ContentValues();
		values.put(KEY_APR, debt.apr);
		values.put(KEY_BALANCE, debt.balance);
		values.put(KEY_BANK, debt.bank);
		values.put(KEY_NAME, debt.name);
		values.put(KEY_PAYMENT_RATE, debt.paymentRate);
		
		return values;
	}
	
	/**
	 * 
	 * @param debt
	 * @return
	 */
	public long createDebt(DebtVO debt)
	{
		ContentValues values = createContentValues(debt);
		
		debt._id = db.insert(DB_TABLE, null, values);
		
		linkPlan(debt);
		
		return debt._id;
	}
	
	/**
	 * 
	 * @param debt
	 * @return
	 */
	public ContentValues createLinkValues(DebtVO debt)
	{
		ContentValues linkValues = new ContentValues();
		linkValues.put("planId", debt.planId);
		linkValues.put("debtId", debt._id);
		
		return linkValues;
	}
	
	/**
	 * 
	 * @param _id
	 * @return
	 */
	public void deletePlan(DebtVO debt)
	{
		// delete any links
		db.delete("planDebts", "debtId = ?", new String[] { Long.toString(debt.planId) });
		db.delete(DB_TABLE, KEY_ROWID + "=?", new String[] { Long.toString(debt._id) });
	}
	
	/**
	 * 
	 * @param plan
	 * @return
	 */
	public Cursor fetchAllDebts(Long planId)
	{
		return db.rawQuery(SQL_FETCH_ALL_DEBTS, new String[] { Long.toString(planId) });
	}
	
	/**
	 * 
	 * @param _id
	 * @return
	 */
	public Cursor fetchDebt(Long _id)
	{
		Cursor cursor = db.query(DB_TABLE, new String[] { KEY_APR, KEY_BALANCE, KEY_BANK, KEY_NAME, KEY_PAYMENT_RATE, KEY_ROWID }, KEY_ROWID + "=?", new String[] { Long.toString(_id) }, null, null, null);
		
		if( cursor != null )
		{
			cursor.moveToFirst();
		}
		
		return cursor;
	}
	
	/**
	 * 
	 * @param debt
	 */
	public void linkPlan(DebtVO debt)
	{
		db.insert("planDebts", null, createLinkValues(debt));
	}

	/**
	 * 
	 * @return
	 * @throws SQLException
	 */
	public DebtDbAdapter open() throws SQLException
	{
		dbHelper = new BaseDBHelper(context);
		db = dbHelper.getWritableDatabase();
		return this;
	}
	
	/**
	 * 
	 * @param debt
	 * @return
	 */
	public void unlinkPlan(DebtVO debt)
	{
		db.delete("planDebts", "planId = ? AND debtId = ?", new String[] { Long.toString(debt.planId), Long.toString(debt._id) });
	}
	
	/**
	 * 
	 * @param debt
	 * @return
	 */
	public void updateDebt(DebtVO debt)
	{
		ContentValues values = createContentValues(debt);
		
		db.update(DB_TABLE, values, KEY_ROWID + "=?", new String[] { Long.toString(debt._id) });
		
		if( debt.active )
		{
			// check to see if linked already
			Cursor cursor = db.query("planDebts", new String[] { "_id" }, "planId = ? AND debtId = ?", new String[] { Long.toString(debt.planId), Long.toString(debt._id) }, null, null, null);
			
			if( cursor.getCount() > 0 )
			{
				cursor.moveToFirst();
				
				if( cursor.getLong(cursor.getColumnIndexOrThrow("_id")) <= 0 )
				{
					// if not, do the link
					linkPlan(debt);
				}
			}
		}
		else
		{
			unlinkPlan(debt);
		}
	}
	
}
