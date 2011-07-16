package com.soatech.debtcountdown.services.interfaces
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.StatsVO;
	
	import mx.collections.ArrayCollection;

	public interface IPayOffService
	{
		function estimateMinimumPayment(balance:Number):Number;
		function determinePayOffSingle(debt:DebtVO, payment:Number, extra:Number=NaN):StatsVO;
		function determinePayOffMultipleByBalance(debtList:ArrayCollection, payment:Number):StatsVO;
		function determinePayOffMultipleByRate(debtList:ArrayCollection, payment:Number):StatsVO;
		function determinePayOffMinimumOnly(debtList:ArrayCollection):StatsVO;
		function determineRemainderPayment(debtList:ArrayCollection, payment:Number, debt:DebtVO):Number;
		function payOffDebts(debtList:ArrayCollection, payment:Number):StatsVO;
		function sortByBalance(a:DebtVO, b:DebtVO, fields:Array = null):int;
		function sortByRate(a:DebtVO, b:DebtVO, fields:Array = null):int;
		
	}
}