package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.RoutineType;
	import com.soatech.debtcountdown.enum.RunPlanStates;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.components.PaymentPlan;
	import com.soatech.debtcountdown.views.components.RunPlan;
	import com.soatech.debtcountdown.views.interfaces.IRunPlanMediator;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class RunPlanMediator extends RunPlanMediatorBase implements IRunPlanMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// localView
		//-----------------------------
		
		public function get localView():RunPlan
		{
			return viewComponent as RunPlan;
		}
		
		//-----------------------------
		// plan
		//-----------------------------
		
		override public function get plan():PlanVO
		{
			return localView.data as PlanVO;
		}
		
		override public function set plan(value:PlanVO):void
		{
			localView.data = value;
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
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
	}
}