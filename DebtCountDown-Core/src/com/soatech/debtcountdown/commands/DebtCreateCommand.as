package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.services.interfaces.IDebtService;
	
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class DebtCreateCommand extends Command implements IResponder
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
		 * @param notification
		 * 
		 */		
		override public function execute():void
		{
			debtService.create( event.debt, this );
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
			var debt:DebtVO = data as DebtVO;
			
			debtProxy.addDebt(debt);
			
			dispatch( new DebtEvent( DebtEvent.CREATE_SUCCESS, debt ) );
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("DebtCreateCommand::fault - " + info.toString()); }
		}
	}
}