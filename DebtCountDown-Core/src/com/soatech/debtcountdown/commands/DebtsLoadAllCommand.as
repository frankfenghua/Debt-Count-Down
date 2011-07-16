package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import org.robotlegs.mvcs.Command;
	
	public class DebtsLoadAllCommand extends Command
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var debtService:IDebtService;
		
		[Inject]
		public var event:DebtEvent;
		
		[Inject]
		public var debtProxy:DebtProxy;
		
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
			debtProxy.debtList = debtService.loadAll();
		}
	}
}