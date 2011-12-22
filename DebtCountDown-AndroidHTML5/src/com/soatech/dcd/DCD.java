package com.soatech.dcd;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;

public class DCD extends Activity {
	
	private WebView webView;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        webView = (WebView) findViewById(R.id.web_view);
        
        webView.getSettings().setJavaScriptEnabled(true);
        
        webView.addJavascriptInterface(new PlanService(webView), "planService");
        
        webView.loadUrl("file:///android_asset/www/index.html");
    }
}