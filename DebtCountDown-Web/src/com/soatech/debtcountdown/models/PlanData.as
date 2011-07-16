package com.soatech.debtcountdown.models
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;

	public class PlanData
	{
		public var plans:Vector.<PlanVO>;
		public var debts:Vector.<DebtVO>;
		
		public function PlanData()
		{
			plans = new Vector.<PlanVO>;
			debts = new Vector.<DebtVO>;
		}
	}
}