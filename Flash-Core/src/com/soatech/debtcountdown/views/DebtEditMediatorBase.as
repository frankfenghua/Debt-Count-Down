package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.services.interfaces.IPayOffService;
	import com.soatech.debtcountdown.views.interfaces.IDebtEdit;
	import com.soatech.debtcountdown.views.interfaces.IDebtEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.TextOperationEvent;
	import spark.validators.NumberValidator;
	
	public class DebtEditMediatorBase extends Mediator implements IDebtEditMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var payOffService:IPayOffService;
		
		[Inject]
		public var debtProxy:DebtProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IDebtEdit
		{
			return viewComponent as IDebtEdit;
		}
		
		//-----------------------------
		// debt
		//-----------------------------
		
		private var _debt:DebtVO;
		
		public function get debt():DebtVO
		{
			return _debt;
		}
		
		public function set debt(value:DebtVO):void
		{
			_debt = value;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var aprValidator:NumberValidator;
		protected var balanceValidator:NumberValidator;
		protected var paymentValidator:NumberValidator;
		protected var bankValidator:StringValidator;
		protected var nameValidator:StringValidator;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( eventDispatcher, DebtEvent.SAVE_SUCCESS, debt_saveSuccessHandler );
			
			eventMap.mapListener( view.backBtn, MouseEvent.CLICK, backBtn_clickHandler );
			eventMap.mapListener( view.balanceTI, TextOperationEvent.CHANGE, balanceTI_changeHandler );
			eventMap.mapListener( view.deleteBtn, MouseEvent.CLICK, deleteBtn_clickHandler );
			eventMap.mapListener( view.estimateBtn, MouseEvent.CLICK, estimateBtn_clickHandler);
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
			if( !isNaN( debt.apr ) )
				view.aprTI.text = debt.apr.toString();
			else
				view.aprTI.text = "";
			
			if( !isNaN( debt.balance ) )
				view.balanceTI.text = debt.balance.toString();
			else
				view.balanceTI.text = "";
			
			view.bankTI.text = debt.bank;
			view.nameTI.text = debt.name;
			
			if( !debt.minPayment && debt.balance )
				view.minPaymentTI.text = payOffService.estimateMinimumPayment(debt.balance).toFixed(2);
			else if( isNaN( debt.minPayment ) )
				view.minPaymentTI.text = "";
			else
				view.minPaymentTI.text = debt.minPayment.toString();
		}
		
		/**
		 * 
		 * 
		 */		
		public function setup():void
		{
			debt = debtProxy.selectedDebt;
			
			if( !debt )
				debt = new DebtVO();
			
			populate();
			setupValidators();
		}
		
		/**
		 * 
		 * 
		 */		
		protected function setupValidators():void
		{
			aprValidator = new NumberValidator();
			aprValidator.listener = view.aprTI;
			aprValidator.property = "apr";
			aprValidator.source = debt;
			aprValidator.fractionalDigits = 6;
			
			balanceValidator = new NumberValidator();
			balanceValidator.listener = view.balanceTI;
			balanceValidator.property = "balance";
			balanceValidator.source = debt;
			balanceValidator.minValue = 1;
			
			paymentValidator = new NumberValidator();
			paymentValidator.listener = view.minPaymentTI;
			paymentValidator.property = "minPayment";
			paymentValidator.source = debt;
			paymentValidator.minValue = 1;
			
			bankValidator = new StringValidator();
			bankValidator.source = debt;
			bankValidator.property = "bank";
			bankValidator.listener = view.bankTI;
			
			nameValidator = new StringValidator();
			nameValidator.source = debt;
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
			
			result = Validator.validateAll( [
				aprValidator, balanceValidator, bankValidator, paymentValidator, nameValidator
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
			dispatch( new DebtEvent( DebtEvent.EDIT_BACK ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function balanceTI_changeHandler(event:TextOperationEvent):void
		{
			if( !debt.minPayment || isNaN( debt.minPayment) || isNaN( Number(view.minPaymentTI.text) ) && !isNaN( Number(view.balanceTI.text) ) )
				view.minPaymentTI.text = payOffService.estimateMinimumPayment(Number(view.balanceTI.text)).toFixed(2);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function debt_saveSuccessHandler(event:DebtEvent):void
		{
			backBtn_clickHandler(null);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function deleteBtn_clickHandler(event:MouseEvent):void
		{
			trace("Not Yet Implemented: deleteBtn_clickHandler");
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function estimateBtn_clickHandler(event:MouseEvent):void
		{
			view.minPaymentTI.text = payOffService.estimateMinimumPayment(Number(view.balanceTI.text)).toFixed(2);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function saveBtn_clickHandler(event:MouseEvent):void
		{
			debt.apr = Number(view.aprTI.text);
			debt.balance = Number(view.balanceTI.text);
			debt.bank = view.bankTI.text;
//			debt.minPayment = Number(view.minPaymentTI.text);
			debt.name = view.nameTI.text;
			
			// calculate payment rate
			debt.paymentRate = Number(view.minPaymentTI.text) / debt.balance;

			if( !validateAll() )
				return;
			
			if( debt.pid )
				dispatch( new DebtEvent( DebtEvent.SAVE, debt ) );
			else
				dispatch( new DebtEvent( DebtEvent.CREATE, debt ) );
		}
	}
}