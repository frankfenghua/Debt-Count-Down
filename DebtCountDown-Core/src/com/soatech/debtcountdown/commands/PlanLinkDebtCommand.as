package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class PlanLinkDebtCommand extends Command implements IResponder
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var event:PlanEvent;
		
		[Inject]
		public var planService:IPlanService;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function execute():void
		{
			planService.linkDebt(event.plan, event.debt, this);
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
			
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("PlanLinkDebtCommand::fault - " + info.toString()); }
		}
	}
}