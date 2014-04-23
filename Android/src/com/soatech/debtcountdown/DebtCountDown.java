package com.soatech.debtcountdown;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

public class DebtCountDown extends Activity implements OnClickListener {
	
	//-------------------------------------------------------------------------
	//
	// Overridden Methods
	//
	//-------------------------------------------------------------------------
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        // try to open and migrate the DB, if successful, go onto the next screen
        
        View splash = findViewById(R.id.splash_image);
        splash.setOnClickListener(this);
        
        goToPlans();
    }

    //-------------------------------------------------------------------------
    //
    // Methods
    //
    //-------------------------------------------------------------------------

    private void goToPlans()
    {
    	Intent i = new Intent(this, Plans.class);
		startActivity(i);
    }
    
    //-------------------------------------------------------------------------
    //
    // Event Handlers
    //
    //-------------------------------------------------------------------------
    
    /**
     * 
     */
    public void onClick(View v) {
    	switch( v.getId() ) {
    		case R.id.splash_image:
    			goToPlans();
    			break;
    	}
    }
}