package com.soatech.debtcountdown.services.interfaces
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public interface IPlanService
	{
		function create(plan:PlanVO, responder:IResponder):void;
		function linkDebt(plan:PlanVO, debt:DebtVO, responder:IResponder):void;
		function load(responder:IResponder):void;
		function remove(plan:PlanVO, responder:IResponder):void;
		function unlinkDebt(plan:PlanVO, debt:DebtVO, responder:IResponder):void;
		function update(plan:PlanVO, responder:IResponder):void;
	}
}