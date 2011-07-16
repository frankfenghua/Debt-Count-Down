package com.soatech.debtcountdown.models
{
	import com.soatech.debtcountdown.models.vo.DebtVO;

	public class DebtData
	{
		public var debts:Vector.<DebtVO>;
		
		public function DebtData()
		{
			debts = new Vector.<DebtVO>;
		}
	}
}