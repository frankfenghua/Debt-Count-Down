package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.interfaces.IPlanSelect;
	import com.soatech.debtcountdown.views.interfaces.IPlanSelectMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class PlanSelectMediatorBase extends Mediator implements IPlanSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
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
			eventMap.mapListener( eventDispatcher, PlanEvent.LIST_CHANGED, plan_listChangedHandler );
			
			// view events
			eventMap.mapListener( view.addBtn, MouseEvent.CLICK, addBtn_clickHandler );
			eventMap.mapListener( view.planList, IndexChangeEvent.CHANGE, planList_changeHandler );
			
			setup();
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
		public function setup():void
		{
			dispatch( new PlanEvent( PlanEvent.LOAD ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		public function addBtn_clickHandler(event:MouseEvent):void
		{
			var plan:PlanVO = new PlanVO();
			
			dispatch( new PlanEvent( PlanEvent.SELECT, plan ) );
			dispatch( new PlanEvent( PlanEvent.EDIT, plan ) );
		}
		
		public function plan_listChangedHandler(event:PlanEvent):void
		{
			if( event.planList.length )
				view.instructions.visible = false;
			else
				view.instructions.visible = true;
				
			view.planList.dataProvider = event.planList;
		}
		
		public function planList_changeHandler(event:IndexChangeEvent):void
		{
			var plan:PlanVO = view.planList.selectedItem as PlanVO;
			
			if( plan )
			{
				dispatch( new PlanEvent( PlanEvent.SELECT, plan ) );
				
				dispatch( new PlanEvent( PlanEvent.EDIT, plan ) );
			}
		}
	}
}