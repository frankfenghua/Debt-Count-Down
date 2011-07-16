package com.soatech.debtcountdown.services.interfaces
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	
	import mx.collections.ArrayCollection;

	public interface IDebtService
	{
		function create(debt:DebtVO):DebtVO;
		function loadAll():ArrayCollection;
		function loadByPlan(planId:int):ArrayCollection;
		function remove(debt:DebtVO):void;
		function update(debt:DebtVO):void;
	}
}