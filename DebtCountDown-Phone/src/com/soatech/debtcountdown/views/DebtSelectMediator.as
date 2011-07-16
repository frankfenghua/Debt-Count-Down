package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.DebtSelectStates;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.views.components.DebtDetails;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.interfaces.IDebtSelectMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.Application;
	import spark.components.TabbedViewNavigatorApplication;
	import spark.components.ViewNavigatorApplication;
	import spark.events.IndexChangeEvent;
	
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