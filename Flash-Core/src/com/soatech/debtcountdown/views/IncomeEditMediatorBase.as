package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.BudgetItemTypes;
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.IncomeEvent;
	import com.soatech.debtcountdown.models.BudgetItemProxy;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.views.interfaces.IIncomeEdit;
	import com.soatech.debtcountdown.views.interfaces.IIncomeEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.validators.NumberValidator;
	
	public class IncomeEditMediatorBase extends Mediator implements IMediator, IIncomeEditMediator
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
		
		private var _incomeItem:BudgetItemVO;
		
		public function get incomeItem():BudgetItemVO
		{
			return _incomeItem;
		}
		
		public function set incomeItem(value:BudgetItemVO):void
		{
			_incomeItem = value;
		}
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IIncomeEdit
		{
			return viewComponent as IIncomeEdit;
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
			addContextListener( BudgetEvent.SAVE_SUCCESS, income_saveSuccessHandler );
			
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
			if( !isNaN( incomeItem.amount ) )
				view.amountTI.text = incomeItem.amount.toString();
			else
				view.amountTI.text = "";
			
			view.nameTI.text = incomeItem.name;
			
			if( incomeItem.pid )
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
			incomeItem = biProxy.selectedItem;
			
			if( !incomeItem )
				incomeItem = new BudgetItemVO();
			
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
			amountValidator.source = incomeItem;
			amountValidator.minValue = 1;
			
			nameValidator = new StringValidator();
			nameValidator.source = incomeItem;
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
			CONFIG::debugtrace{ trace("Not Yet Implemented: IncomeEditMediatorBase::deleteBtn_clickHandler") };
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function income_saveSuccessHandler(event:BudgetEvent):void
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
			incomeItem.name = view.nameTI.text;
			incomeItem.amount = Number(view.amountTI.text);
			incomeItem.type = BudgetItemTypes.INCOME;
			
			if( !validateAll() )
				return;
			
			if( incomeItem.pid )
				dispatch( new BudgetEvent( BudgetEvent.SAVE, incomeItem ) );
			else
				dispatch( new BudgetEvent( BudgetEvent.CREATE, incomeItem ) );
		}
	}
}