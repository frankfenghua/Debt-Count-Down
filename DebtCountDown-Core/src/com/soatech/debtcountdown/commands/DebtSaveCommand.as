package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import org.robotlegs.mvcs.Command;
	
	public class DebtSaveCommand extends Command
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
			debtService.update( event.debt );
			
			debtProxy.replaceDebt( event.debt );
			
			dispatch( new DebtEvent(DebtEvent.SAVE_SUCCESS, event.debt ) );
		}
	}
}