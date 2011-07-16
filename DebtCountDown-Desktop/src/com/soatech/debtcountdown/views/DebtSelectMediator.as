package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.MainStackEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.interfaces.IDebtSelectMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class DebtSelectMediator extends DebtSelectMediatorBase implements IDebtSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var planProxy:PlanProxy;
		
		override public function get plan():PlanVO
		{
			return planProxy.selectedPlan;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_MANAGE, mainStack_switchHandler );
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_DEBT_SELECT, mainStack_switchHandler );
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
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function mainStack_switchHandler(event:MainStackEvent):void
		{
			setup();
		}
	}
}