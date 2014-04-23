package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class DebtsLoadByPlanCommand extends Command implements IResponder
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var event:DebtEvent;
		
		[Inject]
		public var debtProxy:DebtProxy;
		
		[Inject]
		public var debtService:IDebtService;
		
		[Inject]
		public var planProxy:PlanProxy;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override public function execute():void
		{
			debtService.loadByPlan( planProxy.selectedPlan.pid, this );
		}

		//---------------------------------------------------------------------
		//
		// Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function result(data:Object):void
		{
			debtProxy.debtList = data as ArrayCollection;
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("DebtsLoadByPlanCommand::fault - " + info.toString()); }
		}
	}
}