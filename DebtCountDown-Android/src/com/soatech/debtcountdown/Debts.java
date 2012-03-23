package com.soatech.debtcountdown;

import com.soatech.debtcountdown.db.DebtDbAdapter;
import com.soatech.debtcountdown.model.vo.DebtVO;

import android.app.ListActivity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;
import android.widget.Toast;

public class Debts extends ListActivity implements OnClickListener {

	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------
	
	private DebtDbAdapter dbHelper;
	private Cursor cursor;
	private static final int DEBT_EDIT = 10;
	private Long planId;
	
	//-------------------------------------------------------------------------
	//
	// Overridden Methods
	//
	//-------------------------------------------------------------------------

	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.debts);
		
		dbHelper = new DebtDbAdapter(this);
		dbHelper.open();
		
		// get plan
		Bundle extras = getIntent().getExtras();
		planId = (savedInstanceState == null) ? null : (Long) savedInstanceState.getSerializable("planId");
		
		if( extras != null )
		{
			planId = (Long) extras.get("planId");
		}
		
		View add_btn = findViewById(R.id.add_btn);
		add_btn.setOnClickListener(this);
		
//		CheckBox cb = (CheckBox) findViewById(R.id.active_cb); 
//		cb.setOnCheckedChangeListener(new OnCheckedChangeListener() { 
//
//		    @Override 
//		    public void onCheckedChanged(CompoundButton buttonView, 
//		                                            boolean isChecked) { 
//		      if (buttonView.isChecked()) { 
//		        Toast.makeText(getBaseContext(), "Checked", 
//		        Toast.LENGTH_SHORT).show(); 
//		      } 
//		      else 
//		      { 
//		        Toast.makeText(getBaseContext(), "UnChecked", 
//		        Toast.LENGTH_SHORT).show(); 
//		      } 
//		    } 
//		  }); 
		
		fillData();
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
	public void onListItemClick(ListView l, View v, int position, long id)
	{
		// instead of editing, we want to check them off.
		super.onListItemClick(l, v, position, id);
		
		
		
//		Intent i = new Intent(this, DebtDetails.class);
//		i.putExtra(DebtDbAdapter.KEY_ROWID, id);
//		i.putExtra("planId", planId);
//		
//		startActivityForResult(i, DEBT_EDIT);
	}
	
	@Override
	protected void onResume()
	{
		super.onResume();
		fillData();
	}
	
	@Override
	protected void onSaveInstanceState(Bundle outState)
	{
		super.onSaveInstanceState(outState);
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
	private void fillData()
	{
		cursor = dbHelper.fetchAllDebts(planId);
		startManagingCursor(cursor);
		
		String[] from = new String[] { DebtDbAdapter.KEY_NAME };
		int[] to = new int[] { R.id.label };
		
//		SimpleCursorAdapter debts = new SimpleCursorAdapter(this, R.layout.checked_row, cursor, from, to);
//		SimpleCursorAdapter debts = new SimpleCursorAdapter(this, android.R.layout.simple_list_item_multiple_choice, cursor, from, to);
		CheckCursorAdapter debts = new CheckCursorAdapter(this, R.layout.active_row, cursor, from, to);
		debts.setViewBinder(new CheckCursorAdapter.ViewBinder() {
			
			@Override
			public boolean setViewValue(View view, Cursor cursor, int columnIndex) 
			{
				if( columnIndex == 6 )
				{
					DebtVO debt = new DebtVO();
					debt.load(cursor);
					CheckBox cb = (CheckBox) view;
//					Log.w("COLUMN?", cursor.getColumnName(6));
//					Log.w("ACTIVE?", cursor.getString(6));
					Log.w("ACTIVE?", Boolean.toString(debt.active));
					cb.setChecked(cursor.getInt(6) > 0);
					return true;
				}
				return false;
			}
		});

//		getListView().setItemsCanFocus(false);
//		getListView().setChoiceMode(ListView.CHOICE_MODE_MULTIPLE);
		
		setListAdapter(debts);
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
			case R.id.add_btn:
				Intent i = new Intent(this, DebtDetails.class);
				i.putExtra("planId", planId);
				startActivityForResult(i, DEBT_EDIT);
				break;
		}
	}

}
