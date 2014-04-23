package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.views.interfaces.IExpenseSelect;
	import com.soatech.debtcountdown.views.interfaces.IExpenseSelectMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	
	import spark.events.IndexChangeEvent;
	
	public class ExpenseSelectMediator extends ExpenseSelectMediatorBase implements IMediator, IExpenseSelectMediator
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