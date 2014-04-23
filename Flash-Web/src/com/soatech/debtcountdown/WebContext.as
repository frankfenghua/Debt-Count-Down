package com.soatech.debtcountdown
{
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.services.BudgetService;
	import com.soatech.debtcountdown.services.DebtService;
	import com.soatech.debtcountdown.services.PlanService;
	import com.soatech.debtcountdown.services.interfaces.IBudgetService;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	import com.soatech.debtcountdown.views.AppMediator;
	import com.soatech.debtcountdown.views.DebtEditMediator;
	import com.soatech.debtcountdown.views.DebtSelectMediator;
	import com.soatech.debtcountdown.views.DurationChartMediatorBase;
	import com.soatech.debtcountdown.views.ExpenseEditMediator;
	import com.soatech.debtcountdown.views.ExpenseSelectMediator;
	import com.soatech.debtcountdown.views.IncomeEditMediator;
	import com.soatech.debtcountdown.views.IncomeSelectMediator;
	import com.soatech.debtcountdown.views.InterestChartMediatorBase;
	import com.soatech.debtcountdown.views.PaymentPlanMediator;
	import com.soatech.debtcountdown.views.PlanEditMediator;
	import com.soatech.debtcountdown.views.PlanSelectMediator;
	import com.soatech.debtcountdown.views.RunPlanMediator;
	import com.soatech.debtcountdown.views.components.DebtEdit;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.components.DurationChart;
	import com.soatech.debtcountdown.views.components.ExpenseEdit;
	import com.soatech.debtcountdown.views.components.ExpenseSelect;
	import com.soatech.debtcountdown.views.components.IncomeEdit;
	import com.soatech.debtcountdown.views.components.IncomeSelect;
	import com.soatech.debtcountdown.views.components.InterestChart;
	import com.soatech.debtcountdown.views.components.PaymentPlan;
	import com.soatech.debtcountdown.views.components.PlanEdit;
	import com.soatech.debtcountdown.views.components.PlanSelect;
	import com.soatech.debtcountdown.views.components.RunPlan;
	
	import flash.display.DisplayObjectContainer;
	
	public class WebContext extends CoreContext
	{
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param contextView
		 * @param autoStartup
		 * 
		 */
		public function WebContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override public function startup():void
		{
			super.startup();
			
			// services
			injector.mapClass( IBudgetService, BudgetService );
			injector.mapClass( IDebtService, DebtService );
			injector.mapClass( IPlanService, PlanService );
			
			// mediators
			mediatorMap.mapView( DebtCountDownWeb, AppMediator, contextView );
			mediatorMap.mapView( DebtEdit, DebtEditMediator );
			mediatorMap.mapView( DebtSelect, DebtSelectMediator );
			mediatorMap.mapView( DurationChart, DurationChartMediatorBase );
			mediatorMap.mapView( ExpenseEdit, ExpenseEditMediator );
			mediatorMap.mapView( ExpenseSelect, ExpenseSelectMediator );
			mediatorMap.mapView( IncomeEdit, IncomeEditMediator );
			mediatorMap.mapView( IncomeSelect, IncomeSelectMediator );
			mediatorMap.mapView( InterestChart, InterestChartMediatorBase );
			mediatorMap.mapView( PaymentPlan, PaymentPlanMediator );
			mediatorMap.mapView( PlanEdit, PlanEditMediator );
			mediatorMap.mapView( PlanSelect, PlanSelectMediator );
			mediatorMap.mapView( RunPlan, RunPlanMediator );
			
			// switch from the splash screen
			dispatchEvent( new DataBaseEvent( DataBaseEvent.CONNECTED ) );
		}
	}
}