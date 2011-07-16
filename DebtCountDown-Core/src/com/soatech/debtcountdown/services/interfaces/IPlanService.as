package com.soatech.debtcountdown.services.interfaces
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import mx.collections.ArrayCollection;

	public interface IPlanService
	{
		function create(plan:PlanVO):PlanVO;
		function linkDebt(plan:PlanVO, debt:DebtVO):void;
		function load():ArrayCollection;
		function remove(plan:PlanVO):void;
		function unlinkDebt(plan:PlanVO, debt:DebtVO):void;
		function update(plan:PlanVO):void;
	}
}