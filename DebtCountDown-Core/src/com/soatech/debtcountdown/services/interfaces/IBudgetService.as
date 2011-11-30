package com.soatech.debtcountdown.services.interfaces
{
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import mx.rpc.IResponder;

	public interface IBudgetService
	{
		function create(budgetItem:BudgetItemVO, responder:IResponder):void;
		function loadAll(plan:PlanVO, responder:IResponder):void;
		function remove(budgetItem:BudgetItemVO, responder:IResponder):void;
		function update(budgetItem:BudgetItemVO, responder:IResponder):void;
	}
}