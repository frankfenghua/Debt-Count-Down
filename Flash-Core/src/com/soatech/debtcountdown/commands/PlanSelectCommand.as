package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class PlanSelectCommand extends Command
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
			var plan:PlanVO = event.plan;
			
			planProxy.selectedPlan = plan;
		}
	}
}