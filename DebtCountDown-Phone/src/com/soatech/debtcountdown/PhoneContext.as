package com.soatech.debtcountdown
{
	
	import com.soatech.debtcountdown.commands.AppInitCommand;
	import com.soatech.debtcountdown.events.AppEvent;
	import com.soatech.debtcountdown.views.AppMediator;
	import com.soatech.debtcountdown.views.DatePickerMediator;
	import com.soatech.debtcountdown.views.DebtDetailsMediator;
	import com.soatech.debtcountdown.views.DebtSelectMediator;
	import com.soatech.debtcountdown.views.DeleteConfirmMediator;
	import com.soatech.debtcountdown.views.DropDownListMediator;
	import com.soatech.debtcountdown.views.DurationChartMediatorBase;
	import com.soatech.debtcountdown.views.InterestChartMediatorBase;
	import com.soatech.debtcountdown.views.ManageMediator;
	import com.soatech.debtcountdown.views.PaymentPlanMediator;
	import com.soatech.debtcountdown.views.PlanDetailsMedaitor;
	import com.soatech.debtcountdown.views.PlanSelectMediator;
	import com.soatech.debtcountdown.views.RunPlanMediator;
	import com.soatech.debtcountdown.views.components.DatePicker;
	import com.soatech.debtcountdown.views.components.DebtDetails;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.components.DeleteConfirm;
	import com.soatech.debtcountdown.views.components.DropDownList;
	import com.soatech.debtcountdown.views.components.DurationChart;
	import com.soatech.debtcountdown.views.components.InterestChart;
	import com.soatech.debtcountdown.views.components.Manage;
	import com.soatech.debtcountdown.views.components.PaymentPlan;
	import com.soatech.debtcountdown.views.components.PlanDetails;
	import com.soatech.debtcountdown.views.components.PlanSelect;
	import com.soatech.debtcountdown.views.components.RunPlan;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Context;
	
	public class PhoneContext extends CoreContext
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
		public function PhoneContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
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
			
			mediatorMap.mapView( DebtCountDownPhone, AppMediator );
			mediatorMap.mapView( PlanSelect, PlanSelectMediator );
			mediatorMap.mapView( PlanDetails, PlanDetailsMedaitor );
			mediatorMap.mapView( DropDownList, DropDownListMediator );
			mediatorMap.mapView( RunPlan, RunPlanMediator );
			mediatorMap.mapView( DebtDetails, DebtDetailsMediator );
			mediatorMap.mapView( DatePicker, DatePickerMediator );
			mediatorMap.mapView( DeleteConfirm, DeleteConfirmMediator );
			mediatorMap.mapView( DebtSelect, DebtSelectMediator );
			mediatorMap.mapView( Manage, ManageMediator );
			mediatorMap.mapView( PaymentPlan, PaymentPlanMediator );
			mediatorMap.mapView( DurationChart, DurationChartMediatorBase );
			mediatorMap.mapView( InterestChart, InterestChartMediatorBase );
			
			dispatchEvent( new AppEvent( AppEvent.INIT ) );
		}
	}
}