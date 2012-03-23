package com.soatech.debtcountdown;

import com.soatech.debtcountdown.db.DebtDbAdapter;
import com.soatech.debtcountdown.model.vo.DebtVO;

import android.app.Activity;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText;

public class DebtDetails extends Activity implements OnClickListener 
{
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------

	//---------------------------------
	// Aper
	//---------------------------------
	
	/**
	 * 
	 */
	private EditText apr;
	
	/**
	 * 
	 * @return
	 */
	private Double getApr()
	{
		return Double.valueOf(apr.getText().toString());
	}
	
	/**
	 * 
	 * @param value
	 */
	private void setApr(Double value)
	{
		apr.setText(Double.toString(value));
	}
	
	//---------------------------------
	// balance
	//---------------------------------
	
	/**
	 * 
	 */
	private EditText balance;
	
	/**
	 * 
	 * @return
	 */
	private Double getBalance()
	{
		return Double.valueOf(balance.getText().toString());
	}
	
	/**
	 * 
	 * @param value
	 */
	private void setBalance(Double value)
	{
		balance.setText(Double.toString(value));
	}
	
	//---------------------------------
	// bank
	//---------------------------------
	
	/**
	 * 
	 */
	private EditText bank;
	
	/**
	 * 
	 * @return
	 */
	private String getBank()
	{
		return bank.getText().toString();
	}
	
	/**
	 * 
	 * @param value
	 */
	private void setBank(String value)
	{
		bank.setText(value);
	}
	
	//---------------------------------
	// minPayment
	//---------------------------------
	
	/**
	 * 
	 */
	private EditText minPayment;
	
	/**
	 * 
	 * @return
	 */
	private Double getMinPayment()
	{
		return Double.valueOf(minPayment.getText().toString());
	}
	
	/**
	 * 
	 * @param value
	 */
	private void setMinPayment(Double value)
	{
		minPayment.setText(Double.toString(value));
	}
	
	//---------------------------------
	// name
	//---------------------------------
	
	/**
	 * 
	 */
	private EditText name;
	
	/**
	 * 
	 * @return
	 */
	private String getName()
	{
		return name.getText().toString();
	}
	
	/**
	 * 
	 * @param value
	 */
	private void setName(String value)
	{
		name.setText(value);
	}
	
	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------
	
	private Long planId;
	private Long debtId;
	private DebtDbAdapter dbHelper;

	//-------------------------------------------------------------------------
	//
	// Overridden Methods
	//
	//-------------------------------------------------------------------------
	
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.debt_details);
		
		dbHelper = new DebtDbAdapter(this);
		dbHelper.open();
		
		balance = (EditText) findViewById(R.id.edit_debt_balance);
		bank = (EditText) findViewById(R.id.edit_debt_bank);
		name = (EditText) findViewById(R.id.edit_debt_name);
		apr = (EditText) findViewById(R.id.edit_debt_apr);
		minPayment = (EditText) findViewById(R.id.edit_debt_min_payment);
		
		debtId = null;
		planId = null;
		Bundle extras = getIntent().getExtras();
		debtId = (savedInstanceState == null) ? null : (Long) savedInstanceState.getSerializable(DebtDbAdapter.KEY_ROWID);
		planId = (savedInstanceState == null) ? null : (Long) savedInstanceState.getSerializable("planId");
		
		if( extras != null )
		{
			debtId = extras.getLong(DebtDbAdapter.KEY_ROWID);
			planId = extras.getLong("planId");
		}
		
		populate();
		
		View save_btn = findViewById(R.id.save_btn);
		save_btn.setOnClickListener(this);
		
		View cont_btn = findViewById(R.id.cont_btn);
		cont_btn.setOnClickListener(this);
		
		View delete_btn = findViewById(R.id.delete_btn);
		delete_btn.setOnClickListener(this);
		
		View estimate_btn = findViewById(R.id.estimate_btn);
		estimate_btn.setOnClickListener(this);
	}
	
	@Override
	public void onDestroy()
	{
		super.onDestroy();
		if( dbHelper != null )
		{
			dbHelper.close();
		}
	}
	
	@Override
	protected void onPause()
	{
		super.onPause();
//		saveState();
	}
	
	@Override
	protected void onResume()
	{
		super.onResume();
		populate();
	}
	
	@Override
	protected void onSaveInstanceState(Bundle outState)
	{
		super.onSaveInstanceState(outState);
//		saveState();
		outState.putSerializable(DebtDbAdapter.KEY_ROWID, debtId);
		outState.putSerializable("planId", planId);
	}
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 */
	private void deleteDebt()
	{
		if( debtId != null )
		{
			DebtVO debt = new DebtVO();
			debt._id = debtId;
			debt.planId = planId;
			
			dbHelper.deletePlan(debt);
		}
	}

	/**
	 * 
	 */
	private void estimateMinPayment() 
	{
		Double retval = 0.0;
		Double rate = 0.0;
		
		// 3% is the highest I've seen
		rate = 3d / 100d;
		
		retval = Math.floor(getBalance() * rate);
		
		setMinPayment(retval);
	}
	
	/**
	 * 
	 */
	private void populate()
	{
		if( debtId != null && debtId > 0 )
		{
			DebtVO debt = new DebtVO();
			Cursor cursor = dbHelper.fetchDebt(debtId);
			
			debt.load(cursor);
			
			setApr(debt.apr);
			setBalance(debt.balance);
			setBank(debt.bank);
			setName(debt.name);
			setMinPayment(debt.getMinPayment());
		}
	}
	
	/**
	 * 
	 */
	private void saveState()
	{
		DebtVO debt = new DebtVO(debtId, getName(), getBank(), getBalance(), getApr(), 0.0, true, planId);
		
		// calculate payment rate
		debt.paymentRate = getMinPayment() / debt.balance;
		
		if( debtId == null || debtId <= 0 )
		{
			long id = dbHelper.createDebt(debt);
			
			if( id > 0 )
			{
				debtId = id;
			}
		}
		else
		{
			dbHelper.updateDebt(debt);
		}
	}

	//-------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//-------------------------------------------------------------------------
	
	/**
	 * @param v
	 */
	public void onClick(View v)
	{
		switch( v.getId() )
		{
			case R.id.save_btn:
				saveState();
				finish();
				break;
			case R.id.cont_btn:
				break;
			case R.id.delete_btn:
				deleteDebt();
				finish();
				break;
			case R.id.estimate_btn:
				estimateMinPayment();
				break;
		}
	}

}
