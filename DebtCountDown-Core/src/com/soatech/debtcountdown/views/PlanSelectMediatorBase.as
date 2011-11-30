package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.PlanSelectStates;
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.interfaces.IPlanSelect;
	import com.soatech.debtcountdown.views.interfaces.IPlanSelectMediator;
	
	import flash.events.MouseEvent;
	
	import mx.events.StateChangeEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class PlanSelectMediatorBase extends Mediator implements IPlanSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var planProxy:PlanProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IPlanSelect
		{
			return viewComponent as IPlanSelect;
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
			
			// context events
			addContextListener( PlanEvent.LIST_CHANGED, plan_listChangedHandler );
			addContextListener( DataBaseEvent.CONNECTED, dataBase_connectedHandler );
			
			// view events
			addViewListener( StateChangeEvent.CURRENT_STATE_CHANGE, view_stateChangeHandler );
			
			populate();
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */
		public function populate():void
		{
			if( view.currentState == PlanSelectStates.PLANS )
			{
				if( planProxy.planList && planProxy.planList.length )
					view.instructions.visible = false;
				else
					view.instructions.visible = true;
				
				view.planList.dataProvider = planProxy.planList;
			}
		}
		
		/**
		 * 
		 * 
		 */		
		public function setup():void
		{
			dispatch( new PlanEvent( PlanEvent.LOAD ) );
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
		public function addBtn_clickHandler(event:MouseEvent):void
		{
			var plan:PlanVO = new PlanVO();
			
			dispatch( new PlanEvent( PlanEvent.SELECT, plan ) );
			dispatch( new PlanEvent( PlanEvent.EDIT, plan ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function dataBase_connectedHandler(event:DataBaseEvent):void
		{
			view.currentState = PlanSelectStates.PLANS;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function plan_listChangedHandler(event:PlanEvent):void
		{
			populate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function planList_changeHandler(event:IndexChangeEvent):void
		{
			var plan:PlanVO = view.planList.selectedItem as PlanVO;
			
			if( plan )
			{
				dispatch( new PlanEvent( PlanEvent.SELECT, plan ) );
				
				dispatch( new PlanEvent( PlanEvent.EDIT, plan ) );
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function view_stateChangeHandler(event:StateChangeEvent):void
		{
			if( event.newState == PlanSelectStates.PLANS )
			{
				setup();
				eventMap.mapListener( view.addBtn, MouseEvent.CLICK, addBtn_clickHandler );
				eventMap.mapListener( view.planList, IndexChangeEvent.CHANGE, planList_changeHandler );
			}
			
			populate();
		}
	}
}