package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.models.BudgetItemProxy;
	
	import org.robotlegs.mvcs.Command;
	
	public class BudgetItemSelectCommand extends Command
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var biProxy:BudgetItemProxy;

		[Inject]
		public var event:BudgetEvent;
		
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
			biProxy.selectedItem = event.budgetItem;
		}
	}
}