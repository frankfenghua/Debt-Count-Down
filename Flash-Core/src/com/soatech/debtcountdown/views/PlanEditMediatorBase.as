package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.interfaces.IPlanEdit;
	import com.soatech.debtcountdown.views.interfaces.IPlanEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class PlanEditMediatorBase extends Mediator implements IPlanEditMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var planProxy:PlanProxy;
		
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
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IPlanEdit
		{
			return viewComponent as IPlanEdit;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var nameValidator:StringValidator;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// context events
			addContextListener(PlanEvent.SELECTED_CHANGED, plan_selectedChangedHandler );
			addContextListener(PlanEvent.CREATE_SUCCESS, plan_createSuccessHandler );
			addContextListener(PlanEvent.SAVE_SUCCESS, plan_saveSuccessHandler );
			
			// view events
			eventMap.mapListener( view.backBtn, MouseEvent.CLICK, backBtn_clickHandler );
			eventMap.mapListener( view.contBtn, MouseEvent.CLICK, contBtn_clickHandler );
			eventMap.mapListener( view.deleteBtn, MouseEvent.CLICK, deleteBtn_clickHandler );
			eventMap.mapListener( view.saveBtn, MouseEvent.CLICK, saveBtn_clickHandler );
			
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
		public function populate():void
		{
			view.nameTI.text = plan.name;
			
			if( !plan.pid )
			{
				view.deleteBtn.enabled = false;
			}
			else
			{
				view.deleteBtn.enabled = true;
			}
		}
		
		/**
		 * 
		 * 
		 */		
		public function setup():void
		{
			plan = planProxy.selectedPlan;
			
			if( !plan )
				plan = new PlanVO();
			
			setupValidators();
			populate();
		}
		
		/**
		 * 
		 * 
		 */		
		protected function setupValidators():void
		{
			nameValidator = new StringValidator();
			nameValidator.source = plan;
			nameValidator.property = "name";
			nameValidator.listener = view.nameTI;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function validateAll():Boolean
		{
			var result:Array;
			
			result = Validator.validateAll( [nameValidator] );
			
			if( result && result.length )
				return false;
			
			return true;
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
		public function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new PlanEvent( PlanEvent.EDIT_BACK ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function contBtn_clickHandler(event:MouseEvent):void
		{
			saveBtn_clickHandler(event);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function deleteBtn_clickHandler(event:MouseEvent):void
		{
			trace("Not yet implemented: deleteBtn_clickHandler");
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function plan_createSuccessHandler(event:PlanEvent):void
		{
			plan = event.plan;
			
			populate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function plan_saveSuccessHandler(event:PlanEvent):void
		{
			plan = event.plan;
			
			populate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function plan_selectedChangedHandler(event:PlanEvent):void
		{
			plan = event.plan;
			
			populate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function saveBtn_clickHandler(event:MouseEvent):void
		{
			plan.name = view.nameTI.text;
			
			if( !validateAll() )
				return;
			
			if( plan.pid )
				dispatch( new PlanEvent( PlanEvent.SAVE, plan ) );
			else
				dispatch( new PlanEvent( PlanEvent.CREATE, plan ) );
		}
	}
}