package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.interfaces.IPlanEdit;
	import com.soatech.debtcountdown.views.interfaces.IPlanEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.ValidationResultEvent;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	import spark.validators.NumberValidator;
	
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
		
		protected var debtList:ArrayCollection;
		protected var nameValidator:StringValidator;
		protected var expenseValidator:NumberValidator;
		protected var incomeValidator:NumberValidator;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// context events
			eventMap.mapListener( eventDispatcher, PlanEvent.SELECTED_CHANGED, plan_selectedChangedHandler );
			eventMap.mapListener( eventDispatcher, DebtEvent.LIST_CHANGED, debt_listChangedHandler );
			eventMap.mapListener( eventDispatcher, PlanEvent.CREATE_SUCCESS, plan_createSuccessHandler );
			eventMap.mapListener( eventDispatcher, PlanEvent.SAVE_SUCCESS, plan_saveSuccessHandler );
			
			// view events
			eventMap.mapListener( view.debtAddBtn, MouseEvent.CLICK, debtAddBtn_clickHandler );
			eventMap.mapListener( view.backBtn, MouseEvent.CLICK, backBtn_clickHandler );
			eventMap.mapListener( view.runBtn, MouseEvent.CLICK, runBtn_clickHandler );
			eventMap.mapListener( view.saveBtn, MouseEvent.CLICK, saveBtn_clickHandler );
			eventMap.mapListener( view.debtList, IndexChangeEvent.CHANGE, debtList_changeHandler );
			eventMap.mapListener( view.deleteBtn, MouseEvent.CLICK, deleteBtn_clickHandler );
			
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
			
			if( !isNaN( plan.income ) )
				view.incomeTI.text = plan.income.toString();
			else
				view.incomeTI.text = "";
			
			if( !isNaN( plan.expenses ) )
				view.expensesTI.text = plan.expenses.toString();
			else
				view.expensesTI.text = "";
			
			view.debtList.dataProvider = debtList;
			
			if( debtList && debtList.length )
				view.instructions.visible = false;
			else
				view.instructions.visible = true;
				
			
			if( !plan.pid )
			{
				view.debtAddBtn.enabled = false;
				view.deleteBtn.enabled = false;
				view.runBtn.enabled = false;
				view.saveInstructions.visible = true;
				view.instructions.visible = false;
			}
			else
			{
				view.debtAddBtn.enabled = true;
				view.deleteBtn.enabled = true;
				view.runBtn.enabled = true;
				view.saveInstructions.visible = false;
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
			
			dispatch( new DebtEvent( DebtEvent.LOAD_BY_PLAN, null, null, plan ) );
		}
		
		/**
		 * 
		 * 
		 */		
		protected function setupValidators():void
		{
			expenseValidator = new NumberValidator();
			expenseValidator.listener = view.expensesTI;
			expenseValidator.property = "expenses";
			expenseValidator.source = plan;
			expenseValidator.minValue = 1;

			incomeValidator = new NumberValidator();
			incomeValidator.listener = view.incomeTI;
			incomeValidator.property = "income";
			incomeValidator.source = plan;
			incomeValidator.minValue = 1;
			
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
			
			result = Validator.validateAll( [expenseValidator, incomeValidator, nameValidator] );
			
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
		public function debtAddBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new DebtEvent( DebtEvent.SHOW_SELECT, null, null, plan ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function debtList_changeHandler(event:IndexChangeEvent):void
		{
			var debt:DebtVO = view.debtList.selectedItem as DebtVO;
			
			if( !debt )
				return;
			
			dispatch( new DebtEvent( DebtEvent.SELECT, debt ) );
			
			debt.planId = plan.pid;
			
			dispatch( new DebtEvent( DebtEvent.EDIT, debt ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function debt_listChangedHandler(event:DebtEvent):void
		{
			debtList = event.debtList;
			
			populate();
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
		public function runBtn_clickHandler(event:MouseEvent):void
		{
			if( !validateAll() )
				return;
			
			dispatch( new PaymentPlanEvent( PaymentPlanEvent.SHOW_RUN, null, plan ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function saveBtn_clickHandler(event:MouseEvent):void
		{
			plan.expenses = Number(view.expensesTI.text);
			plan.income = Number(view.incomeTI.text);
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