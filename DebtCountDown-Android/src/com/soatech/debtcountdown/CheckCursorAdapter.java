package com.soatech.debtcountdown;

import android.content.Context;
import android.database.Cursor;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.SimpleCursorAdapter;
import android.widget.Toast;

public class CheckCursorAdapter extends SimpleCursorAdapter {

	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 * @param context
	 * @param layout
	 * @param cursor
	 * @param to
	 * @param from
	 */
	public CheckCursorAdapter(Context context, int layout, Cursor cursor, String[] to, int[] from)
	{
		super(context, layout, cursor, to, from);
	}

	//-------------------------------------------------------------------------
	//
	// Overridden Methods
	//
	//-------------------------------------------------------------------------
	
	@Override
	public View getView(int position, View convertView, ViewGroup parent)
	{
		CheckBox cb = (CheckBox) parent.findViewById(R.id.active_cb);
		if( cb != null )
		{
			cb.setOnCheckedChangeListener(new OnCheckedChangeListener() {
				
				@Override
				public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
					Toast.makeText(buttonView.getContext(), "Checked", 5);
				}
			});
		}
		return super.getView(position, convertView, parent);
	}
}
