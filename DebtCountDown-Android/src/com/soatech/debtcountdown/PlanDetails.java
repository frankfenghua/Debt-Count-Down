package com.soatech.debtcountdown;

import com.soatech.debtcountdown.db.PlanDbAdapter;
import com.soatech.debtcountdown.model.vo.PlanVO;

import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText;

public class PlanDetails extends Activity implements OnClickListener {

	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------

	private EditText planName;
	private Long planId;
	private PlanDbAdapter dbHelper;
	
	//-------------------------------------------------------------------------
	//
	// Overridden Methods
	//
	//-------------------------------------------------------------------------
	
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.plan_details);
		
		dbHelper = new PlanDbAdapter(this);
		dbHelper.open();
		
		planName = (EditText) findViewById(R.id.edit_plan_name);
		planId = null;
		Bundle extras = getIntent().getExtras();
		planId = (savedInstanceState == null) ? null : (Long) savedInstanceState.getSerializable(PlanDbAdapter.KEY_ROWID);
		
		if( extras != null )
		{
			planId = extras.getLong(PlanDbAdapter.KEY_ROWID);
		}
		
		populate();
				
		View save_btn = findViewById(R.id.save_btn);
		save_btn.setOnClickListener(this);
		
		View cont_btn = findViewById(R.id.cont_btn);
		cont_btn.setOnClickListener(this);
		
		View delete_btn = findViewById(R.id.delete_btn);
		delete_btn.setOnClickListener(this);
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
		saveState();
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
		saveState();
		outState.putSerializable(PlanDbAdapter.KEY_ROWID, planId);
	}

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * 
	 */
	private void deletePlan()
	{
		if( planId != null )
		{
			dbHelper.deletePlan(planId);
		}
	}
	
	/**
	 * 
	 */
	private void populate() 
	{
		if( planId != null )
		{
			PlanVO plan = new PlanVO();
			Cursor cursor = dbHelper.fetchPlan(planId);
		
			plan.load(cursor);
			
			planName.setText(plan.name);
		}
	}
	
	/**
	 * 
	 */
	private void saveState()
	{
		String name = planName.getText().toString();
		
		if( planId == null )
		{
			long id = dbHelper.createPlan(new PlanVO(null, name));
			if( id > 0 )
			{
				planId = id;
			}
		} 
		else 
		{
			dbHelper.updatePlan(new PlanVO(planId, name));
		}
	}
	
	//-------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 */
	public void onClick(View v) 
	{
		switch( v.getId() )
		{
			case R.id.save_btn:
				// save item and go back to list
				saveState();
				finish();
				break;
			case R.id.cont_btn:
				// save item and go to next screen
				saveState();
				Intent i = new Intent(this, Debts.class);
				i.putExtra("planId", planId);
				startActivity(i);
				break;
			case R.id.delete_btn:
				// delete item and go to next screen
				deletePlan();
				finish();
				break;
		}
	}

}
