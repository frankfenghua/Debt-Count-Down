package com.soatech.debtcountdown
{
	import com.soatech.debtcountdown.commands.BudgetItemCreateCommand;
	import com.soatech.debtcountdown.commands.BudgetItemDeleteCommand;
	import com.soatech.debtcountdown.commands.BudgetItemSaveCommand;
	import com.soatech.debtcountdown.commands.BudgetItemSelectCommand;
	import com.soatech.debtcountdown.commands.BudgetsLoadAllCommand;
	import com.soatech.debtcountdown.commands.DebtCreateCommand;
	import com.soatech.debtcountdown.commands.DebtDeleteCommand;
	import com.soatech.debtcountdown.commands.DebtSaveCommand;
	import com.soatech.debtcountdown.commands.DebtSelectCommand;
	import com.soatech.debtcountdown.commands.DebtsLoadAllCommand;
	import com.soatech.debtcountdown.commands.DebtsLoadByPlanCommand;
	import com.soatech.debtcountdown.commands.PaymentPlanRunCommand;
	import com.soatech.debtcountdown.commands.PlanCreateCommand;
	import com.soatech.debtcountdown.commands.PlanDeleteCommand;
	import com.soatech.debtcountdown.commands.PlanLinkBudgetItemCommand;
	import com.soatech.debtcountdown.commands.PlanLinkDebtCommand;
	import com.soatech.debtcountdown.commands.PlanSaveCommand;
	import com.soatech.debtcountdown.commands.PlanSelectCommand;
	import com.soatech.debtcountdown.commands.PlanUnlinkBudgetItemCommand;
	import com.soatech.debtcountdown.commands.PlanUnlinkDebtCommand;
	import com.soatech.debtcountdown.commands.PlansLoadCommand;
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.helpers.ELSHelper;
	import com.soatech.debtcountdown.models.BudgetItemProxy;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.FrequencyProxy;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.services.PayOffService;
	import com.soatech.debtcountdown.services.interfaces.IPayOffService;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Context;
	
	public class CoreContext extends Context implements IContext
	{
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param contextView
		 * @param autoStartup
		 * 
		 */		
		public function CoreContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override public function startup():void
		{
			super.startup();
			
			// model
			injector.mapSingleton( BudgetItemProxy );
			injector.mapSingleton( DebtProxy );
			injector.mapSingleton( ELSHelper );
			injector.mapSingleton( FrequencyProxy );
			injector.mapSingleton( PlanProxy );
			injector.mapSingleton( StatsProxy );
			
			// services
			
			injector.mapClass( IPayOffService, PayOffService );
			
			// commands
			
			commandMap.mapEvent( BudgetEvent.CREATE, BudgetItemCreateCommand );
			commandMap.mapEvent( BudgetEvent.DELETE, BudgetItemDeleteCommand );
			commandMap.mapEvent( BudgetEvent.LOAD_ALL, BudgetsLoadAllCommand );
			commandMap.mapEvent( BudgetEvent.SAVE, BudgetItemSaveCommand );
			commandMap.mapEvent( BudgetEvent.SELECT, BudgetItemSelectCommand );

			commandMap.mapEvent( DebtEvent.CREATE, DebtCreateCommand, DebtEvent );
			commandMap.mapEvent( DebtEvent.DELETE, DebtDeleteCommand );
			commandMap.mapEvent( DebtEvent.LOAD_ALL, DebtsLoadAllCommand, DebtEvent );
			commandMap.mapEvent( DebtEvent.LOAD_BY_PLAN, DebtsLoadByPlanCommand, DebtEvent );
			commandMap.mapEvent( DebtEvent.SAVE, DebtSaveCommand, DebtEvent );
			commandMap.mapEvent( DebtEvent.SELECT, DebtSelectCommand, DebtEvent );
			
			commandMap.mapEvent( PaymentPlanEvent.RUN, PaymentPlanRunCommand );
			
			commandMap.mapEvent( PlanEvent.CREATE, PlanCreateCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.DELETE, PlanDeleteCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.LINK_BUDGET_ITEM, PlanLinkBudgetItemCommand );
			commandMap.mapEvent( PlanEvent.LINK_DEBT, PlanLinkDebtCommand );
			commandMap.mapEvent( PlanEvent.LOAD, PlansLoadCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.SELECT, PlanSelectCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.SAVE, PlanSaveCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.UNLINK_BUDGET_ITEM, PlanUnlinkBudgetItemCommand );
			commandMap.mapEvent( PlanEvent.UNLINK_DEBT, PlanUnlinkDebtCommand );
			
		}
	}
}