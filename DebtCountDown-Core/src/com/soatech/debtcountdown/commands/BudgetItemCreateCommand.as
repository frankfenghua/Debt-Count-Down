package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.models.BudgetItemProxy;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.services.interfaces.IBudgetService;
	
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class BudgetItemCreateCommand extends Command implements IResponder
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var biProxy:BudgetItemProxy;
		
		[Inject]
		public var budgetService:IBudgetService;

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
			budgetService.create(event.budgetItem, this);
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
			var income:BudgetItemVO = data as BudgetItemVO;
			
			biProxy.addBudgetItem( income );
			
			dispatch( new BudgetEvent( BudgetEvent.CREATE_SUCCESS, income ) );
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("BudgetItemCreateCommand::fault - " + info.toString()); }
		}
	}
}