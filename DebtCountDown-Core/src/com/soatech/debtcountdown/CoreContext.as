package com.soatech.debtcountdown
{
	import com.adobe.protocols.dict.events.DatabaseEvent;
	import com.soatech.debtcountdown.commands.AppInitCommand;
	import com.soatech.debtcountdown.commands.DatabaseConnectCommand;
	import com.soatech.debtcountdown.commands.DebtCreateCommand;
	import com.soatech.debtcountdown.commands.DebtDeleteCommand;
	import com.soatech.debtcountdown.commands.DebtSaveCommand;
	import com.soatech.debtcountdown.commands.DebtSelectCommand;
	import com.soatech.debtcountdown.commands.DebtsLoadAllCommand;
	import com.soatech.debtcountdown.commands.DebtsLoadByPlanCommand;
	import com.soatech.debtcountdown.commands.MigrationsRunCommand;
	import com.soatech.debtcountdown.commands.PaymentPlanRunCommand;
	import com.soatech.debtcountdown.commands.PlanCreateCommand;
	import com.soatech.debtcountdown.commands.PlanDeleteCommand;
	import com.soatech.debtcountdown.commands.PlanLinkDebtCommand;
	import com.soatech.debtcountdown.commands.PlanSaveCommand;
	import com.soatech.debtcountdown.commands.PlanSelectCommand;
	import com.soatech.debtcountdown.commands.PlanUnlinkDebtCommand;
	import com.soatech.debtcountdown.commands.PlansLoadCommand;
	import com.soatech.debtcountdown.events.AppEvent;
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.MigrationEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.helpers.ELSHelper;
	import com.soatech.debtcountdown.models.DataBaseProxy;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.services.DebtService;
	import com.soatech.debtcountdown.services.PayOffService;
	import com.soatech.debtcountdown.services.PlanService;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	import com.soatech.debtcountdown.services.interfaces.IPayOffService;
	import com.soatech.debtcountdown.services.interfaces.IPlanService;
	
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
			injector.mapSingleton( DataBaseProxy );
			injector.mapSingleton( DebtProxy );
			injector.mapSingleton( ELSHelper );
			injector.mapSingleton( PlanProxy );
			injector.mapSingleton( StatsProxy );
			
			// services
			injector.mapSingletonOf( IDebtService, DebtService );
			injector.mapSingletonOf( IPayOffService, PayOffService );
			injector.mapSingletonOf( IPlanService, PlanService );
			
			// commands
			commandMap.mapEvent( AppEvent.INIT, AppInitCommand );
			
			commandMap.mapEvent( DataBaseEvent.CONNECT, DatabaseConnectCommand );
			
			commandMap.mapEvent( DebtEvent.CREATE, DebtCreateCommand, DebtEvent );
			commandMap.mapEvent( DebtEvent.DELETE, DebtDeleteCommand );
			commandMap.mapEvent( DebtEvent.LOAD_ALL, DebtsLoadAllCommand, DebtEvent );
			commandMap.mapEvent( DebtEvent.LOAD_BY_PLAN, DebtsLoadByPlanCommand, DebtEvent );
			commandMap.mapEvent( DebtEvent.SAVE, DebtSaveCommand, DebtEvent );
			commandMap.mapEvent( DebtEvent.SELECT, DebtSelectCommand, DebtEvent );
			
			commandMap.mapEvent( MigrationEvent.RUN, MigrationsRunCommand );
			
			commandMap.mapEvent( PaymentPlanEvent.RUN, PaymentPlanRunCommand );
			
			commandMap.mapEvent( PlanEvent.CREATE, PlanCreateCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.DELETE, PlanDeleteCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.LINK_DEBT, PlanLinkDebtCommand );
			commandMap.mapEvent( PlanEvent.LOAD, PlansLoadCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.SELECT, PlanSelectCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.SAVE, PlanSaveCommand, PlanEvent );
			commandMap.mapEvent( PlanEvent.UNLINK_DEBT, PlanUnlinkDebtCommand );
			
		}
	}
}