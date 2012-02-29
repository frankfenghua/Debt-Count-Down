package com.soatech.debtcountdown
{
	import com.soatech.debtcountdown.events.AppEvent;
	import com.soatech.debtcountdown.views.AppMediator;
	import com.soatech.debtcountdown.views.DebtEditMediator;
	import com.soatech.debtcountdown.views.DebtSelectMediator;
	import com.soatech.debtcountdown.views.DurationChartMediatorBase;
	import com.soatech.debtcountdown.views.InterestChartMediatorBase;
	import com.soatech.debtcountdown.views.PaymentPlanMediator;
	import com.soatech.debtcountdown.views.PlanEditMediator;
	import com.soatech.debtcountdown.views.PlanListRendererMediator;
	import com.soatech.debtcountdown.views.PlanSelectMediator;
	import com.soatech.debtcountdown.views.RunPlanMediator;
	import com.soatech.debtcountdown.views.components.DebtEdit;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.components.DurationChart;
	import com.soatech.debtcountdown.views.components.InterestChart;
	import com.soatech.debtcountdown.views.components.PaymentPlan;
	import com.soatech.debtcountdown.views.components.PlanEdit;
	import com.soatech.debtcountdown.views.components.PlanSelect;
	import com.soatech.debtcountdown.views.components.RunPlan;
	import com.soatech.debtcountdown.views.renderers.PlanListRenderer;
	
	import flash.display.DisplayObjectContainer;
	
	public class DesktopContext extends CoreContext
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
		public function DesktopContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
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
			
			// mediators
			mediatorMap.mapView( DebtCountDownDesktop, AppMediator, contextView );
			mediatorMap.mapView( DebtEdit, DebtEditMediator );
			mediatorMap.mapView( DebtSelect, DebtSelectMediator );
			mediatorMap.mapView( PlanEdit, PlanEditMediator );
			mediatorMap.mapView( PlanListRenderer, PlanListRendererMediator );
			mediatorMap.mapView( PlanSelect, PlanSelectMediator );
			mediatorMap.mapView( RunPlan, RunPlanMediator );
			mediatorMap.mapView( DurationChart, DurationChartMediatorBase );
			mediatorMap.mapView( InterestChart, InterestChartMediatorBase );
			mediatorMap.mapView( PaymentPlan, PaymentPlanMediator );
			
			dispatchEvent( new AppEvent( AppEvent.INIT ) );
		}
	}
}