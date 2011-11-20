package com.soatech.debtcountdown.services.interfaces
{
	import mx.rpc.IResponder;

	public interface IFrequencyService
	{
		function loadAll(responder:IResponder):void;
	}
}