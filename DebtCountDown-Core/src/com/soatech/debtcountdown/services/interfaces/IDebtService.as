package com.soatech.debtcountdown.services.interfaces
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public interface IDebtService
	{
		function create(debt:DebtVO, responder:IResponder):void;
		function loadAll(responder:IResponder):void;
		function loadByPlan(planId:int, responder:IResponder):void;
		function remove(debt:DebtVO, responder:IResponder):void;
		function update(debt:DebtVO, responder:IResponder):void;
	}
}