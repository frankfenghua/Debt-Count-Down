package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class PlanSaveCommand extends Command implements IResponder
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var event:PlanEvent;

		[Inject]
		public var planProxy:PlanProxy;
		
		[Inject]
		public var planService:IPlanService;
		
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
			planService.update( event.plan, this );
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
			planProxy.replacePlan( event.plan );
			
			dispatch( new PlanEvent(PlanEvent.SAVE_SUCCESS, event.plan ) );
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("PlanSaveCommand::fault - " + info.toString()); }
		}
	}
}