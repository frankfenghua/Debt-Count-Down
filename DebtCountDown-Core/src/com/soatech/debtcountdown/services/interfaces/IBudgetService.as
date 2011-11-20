package com.soatech.debtcountdown.services.interfaces
{
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	
	import mx.rpc.IResponder;

	public interface IBudgetService
	{
		function create(budgetItem:BudgetItemVO, responder:IResponder):void;
		function loadAll(responder:IResponder):void;
		function remove(budgetItem:BudgetItemVO, responder:IResponder):void;
		function update(budgetItem:BudgetItemVO, responder:IResponder):void;
	}
}