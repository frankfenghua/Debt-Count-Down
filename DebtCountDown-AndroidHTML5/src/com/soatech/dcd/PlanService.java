package com.soatech.dcd;

import com.google.gson.Gson;
import android.webkit.WebView;

public class PlanService {

	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------
	
	private WebView view;
	
	private Gson gson;
	
	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------
	
	public PlanService(WebView view) {
		this.view = view;
		
		gson = new Gson();
	}
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * 
	 * @param plan
	 * @param onResult
	 * @param onFault
	 */
	public void addPlan(String plan, String onResult, String onFault)
	{
		PlanVO test = gson.fromJson(plan, PlanVO.class);
		test.pid = (int) Math.floor(Math.random() * 100);
		
		String url = "javascript:" + onResult + "(" + gson.toJson(test) + ");";
		view.loadUrl(url);
	}
	
	/**
	 * 
	 * @param plan
	 * @param onResult
	 * @param onFault
	 */
	public void editPlan(String plan, String onResult, String onFault)
	{
		PlanVO test = gson.fromJson(plan, PlanVO.class);
		
		String url = "javascript:" + onResult + "(" + gson.toJson(test) + ");";
		view.loadUrl(url);
	}
	
	/**
	 * 
	 * @param onResult
	 * @param onFault
	 */
	public void loadAllPlans(String onResult, String onFault) {
		String url = "javascript: " + onResult + "([{\"id\":\"1\", \"name\":\"Plan1\"}]);";
		view.loadUrl(url);
	}
	
}
