package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.interfaces.IDebtSelectMediator;
	
	public class DebtSelectMediator extends DebtSelectMediatorBase implements IDebtSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// localView
		//-----------------------------
		
		public function get localView():DebtSelect
		{
			return viewComponent as DebtSelect;
		}
		
		//-----------------------------
		// plan
		//-----------------------------
		
		override public function get plan():PlanVO
		{
			return localView.data as PlanVO;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
	}
}