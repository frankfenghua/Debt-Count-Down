package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.models.DataBaseProxy;
	import com.soatech.debtcountdown.services.interfaces.IFrequencyService;
	
	import mx.rpc.IResponder;
	
	public class FrequencyService implements IFrequencyService
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var dbProxy:DataBaseProxy;

		//---------------------------------------------------------------------
		//
		// SQL
		//
		//---------------------------------------------------------------------

		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 */
		private var responder:IResponder;
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param responder
		 * 
		 */
		public function loadAll(responder:IResponder):void
		{
			this.responder = responder;
		}

		//---------------------------------------------------------------------
		//
		// Result Handlers
		//
		//---------------------------------------------------------------------

		//---------------------------------------------------------------------
		//
		// Fault Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param info
		 * 
		 */
		private function onFail(info:Object):void
		{
			responder.fault(info);
		}
	}
}