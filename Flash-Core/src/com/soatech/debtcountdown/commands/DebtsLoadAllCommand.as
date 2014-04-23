package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class DebtsLoadAllCommand extends Command implements IResponder
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
			debtService.loadAll(this);
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
			CONFIG::debugtrace{ trace("DebtsLoadAllCommand::fault - " + info.toString()); }
		}
	}
}