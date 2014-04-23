package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class PlansLoadCommand extends Command implements IResponder
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
		 * @param notification
		 * 
		 */		
		override public function execute():void
		{
//			planProxy.planList = planService.load(this);
			planService.load(this);
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
			planProxy.planList = data as ArrayCollection;
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