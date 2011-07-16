package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.RoutineType;
	import com.soatech.debtcountdown.enum.RunPlanStates;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.interfaces.IRunPlan;
	import com.soatech.debtcountdown.views.interfaces.IRunPlanMediator;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class RunPlanMediatorBase extends Mediator implements IRunPlanMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var statsProxy:StatsProxy;

		[Inject]
		public var planProxy:PlanProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IRunPlan
		{
			return viewComponent as IRunPlan;
		}
		
		//-----------------------------
		// plan
		//-----------------------------
		
		private var _plan:PlanVO;
		
		public function get plan():PlanVO
		{
			return _plan;
		}
		
		public function set plan(value:PlanVO):void
		{
			_plan = value;
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
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( view.backBtn, MouseEvent.CLICK, backBtn_clickHandler );
			eventMap.mapListener( eventDispatcher, PaymentPlanEvent.RUN_COMPLETE, plan_runCompleteHandler );
			
			setup();
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		public function setup():void
		{
			plan = planProxy.selectedPlan;
			view.setState(RunPlanStates.RUNNING);
			dispatch( new PaymentPlanEvent( PaymentPlanEvent.RUN, null, plan ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		public function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new PaymentPlanEvent( PaymentPlanEvent.BACK ) );
		}
		
		public function plan_runCompleteHandler(event:PaymentPlanEvent):void
		{
			view.setState(RunPlanStates.SUMMARY);
		}
	}
}