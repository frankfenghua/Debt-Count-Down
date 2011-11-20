package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.BudgetItemTypes;
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.ExpenseEvent;
	import com.soatech.debtcountdown.models.BudgetItemProxy;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.views.interfaces.IExpenseEdit;
	import com.soatech.debtcountdown.views.interfaces.IExpenseEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.validators.NumberValidator;
	
	public class ExpenseEditMediatorBase extends Mediator implements IMediator, IExpenseEditMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var biProxy:BudgetItemProxy;
		
		//-----------------------------
		// incomeItem
		//-----------------------------
		
		private var _expenseItem:BudgetItemVO;
		
		public function get expenseItem():BudgetItemVO
		{
			return _expenseItem;
		}
		
		public function set expenseItem(value:BudgetItemVO):void
		{
			_expenseItem = value;
		}
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IExpenseEdit
		{
			return viewComponent as IExpenseEdit;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var amountValidator:NumberValidator;
		protected var nameValidator:StringValidator;
		
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
			
			// context listeners
			addContextListener( BudgetEvent.SAVE_SUCCESS, expense_saveSuccessHandler );
			
			// view listeners
			eventMap.mapListener( view.backBtn, MouseEvent.CLICK, backBtn_clickHandler );
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
			if( !isNaN( expenseItem.amount ) )
				view.amountTI.text = expenseItem.amount.toString();
			else
				view.amountTI.text = "";
			
			view.nameTI.text = expenseItem.name;
			
			if( expenseItem.pid )
				view.deleteBtn.enabled = true;
			else
				view.deleteBtn.enabled = false;
				
		}
		
		/**
		 * 
		 * 
		 */
		public function setup():void
		{
			expenseItem = biProxy.selectedItem;
			
			if( !expenseItem )
				expenseItem = new BudgetItemVO();
			
			populate();
			setupValidators();
		}
		
		/**
		 * 
		 * 
		 */
		protected function setupValidators():void
		{
			amountValidator = new NumberValidator();
			amountValidator.listener = view.amountTI;
			amountValidator.property = 'amount';
			amountValidator.source = expenseItem;
			amountValidator.minValue = 1;
			
			nameValidator = new StringValidator();
			nameValidator.source = expenseItem;
			nameValidator.property = 'name';
			nameValidator.listener = view.nameTI;
		}
		
		/**
		 * 
		 * 
		 */
		public function validateAll():Boolean
		{
			var result:Array;
			
			result = Validator.validateAll( [
				amountValidator, nameValidator
			] );
			
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
			dispatch( new BudgetEvent( BudgetEvent.EDIT_BACK ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function deleteBtn_clickHandler(event:MouseEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: ExpenseEditMediatorBase::deleteBtn_clickHandler") };
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function expense_saveSuccessHandler(event:BudgetEvent):void
		{
			backBtn_clickHandler(null);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function saveBtn_clickHandler(event:MouseEvent):void
		{
			expenseItem.name = view.nameTI.text;
			expenseItem.amount = Number(view.amountTI.text);
			expenseItem.type = BudgetItemTypes.EXPENSE;
			
			if( !validateAll() )
				return;
			
			if( expenseItem.pid )
				dispatch( new BudgetEvent( BudgetEvent.SAVE, expenseItem ) );
			else
				dispatch( new BudgetEvent( BudgetEvent.CREATE, expenseItem ) );
		}
	}
}