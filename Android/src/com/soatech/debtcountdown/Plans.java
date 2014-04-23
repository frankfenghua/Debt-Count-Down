package com.soatech.debtcountdown;

import com.soatech.debtcountdown.db.PlanDbAdapter;

import android.app.ListActivity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;

public class Plans extends ListActivity implements OnClickListener {

	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------

	private PlanDbAdapter dbHelper;
	private Cursor cursor;
	private static final int PLAN_EDIT = 1;
	
	//-------------------------------------------------------------------------
	//
	// Overridden Methods
	//
	//-------------------------------------------------------------------------
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.plans);
        
        dbHelper = new PlanDbAdapter(this);
        dbHelper.open();
        
        // event handlers
        View add_btn = findViewById(R.id.add_btn);
        add_btn.setOnClickListener(this);
        
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
    	super.onListItemClick(l, v, position, id);
    	Intent i = new Intent(this, PlanDetails.class);
    	i.putExtra(PlanDbAdapter.KEY_ROWID, id);
    	
    	startActivityForResult(i, PLAN_EDIT);
    }
    
    //-------------------------------------------------------------------------
    //
    // Methods
    //
    //-------------------------------------------------------------------------
	    
    /**
     * 
     */
    private void fillData() {
		cursor = dbHelper.fetchAllPlans();
		startManagingCursor(cursor);
		
		String[] from = new String[]{ PlanDbAdapter.KEY_NAME };
		int[] to = new int[] { R.id.label };
		
		SimpleCursorAdapter plans = new SimpleCursorAdapter(this, R.layout.plans_row, cursor, from, to);
		
		setListAdapter(plans);
	}

	//-------------------------------------------------------------------------
    //
    // Event Handlers
    //
    //-------------------------------------------------------------------------

    /**
     * @param v
     */
	public void onClick(View v) {
		switch( v.getId() )
		{
			case R.id.add_btn:
				Intent i = new Intent(this, PlanDetails.class);
				startActivityForResult(i, PLAN_EDIT);
				break;
		}
	}

}
