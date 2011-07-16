package com.soatech.debtcountdown.models.vo
{
	import mx.collections.ArrayCollection;

	public class StatsVO
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var monthsToPayOff:int;
		public var totalInterestPaid:Number;
		public var paymentRemaining:Number;
		public var paymentPlan:ArrayCollection;
	}
}