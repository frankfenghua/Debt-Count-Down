package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.MainStackEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.components.PlanEdit;
	import com.soatech.debtcountdown.views.interfaces.IPlanEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class PlanEditMediator extends PlanEditMediatorBase implements IPlanEditMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
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
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_PLAN_EDIT, mainStack_switchHandler );
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		override public function populate():void
		{
			if( !plan )
				return;
			
			super.populate();
		}
		
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
		protected function confirmation_closeHandler(event:CloseEvent):void
		{
			if( event.detail == Alert.YES )
			{
				dispatch( new PlanEvent( PlanEvent.DELETE, plan ) );
				dispatch( new PlanEvent( PlanEvent.EDIT_BACK ) );
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function deleteBtn_clickHandler(event:MouseEvent):void
		{
			Alert.show("Are you sure you want to delete " + plan.name + "?", 
				"Delete Confirmation", Alert.YES|Alert.NO, null, 
				confirmation_closeHandler);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function mainStack_switchHandler(event:MainStackEvent):void
		{
			setup();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function plan_selectedChangedHandler(event:PlanEvent):void
		{
			plan = event.plan;
			
			if( !plan )
				return;
			
			dispatch( new DebtEvent( DebtEvent.LOAD_BY_PLAN, null, null, plan ) );
			
			populate();
		}
	}
}