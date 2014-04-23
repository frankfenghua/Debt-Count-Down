package com.soatech.debtcountdown.models.vo
{
	public class PaymentPlanVO
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var debt:DebtVO;
		public var payment:Number;
		public var balance:Number;
		public var month:int;

		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param debt
		 * @param payment
		 * @param balance
		 * @param month
		 * 
		 */
		public function PaymentPlanVO(debt:DebtVO=null, payment:Number=NaN, balance:Number=NaN, month:int=0)
		{
			this.balance = balance;
			this.debt = debt;
			this.payment = payment;
			this.month = month;
		}
	}
}