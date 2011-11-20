package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.views.interfaces.IIncomeSelectMediator;
	
	import org.robotlegs.core.IMediator;
	
	public class IncomeSelectMediator extends IncomeSelectMediatorBase implements IMediator, IIncomeSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */
		override public function onRegister():void
		{
			super.onRegister();
		}
	}
}