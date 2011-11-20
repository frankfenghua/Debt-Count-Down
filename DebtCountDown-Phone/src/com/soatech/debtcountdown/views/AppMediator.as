package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.BudgetItemTypes;
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.ExpenseEvent;
	import com.soatech.debtcountdown.events.IncomeEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.events.RotateEvent;
	import com.soatech.debtcountdown.views.components.DebtEdit;
	import com.soatech.debtcountdown.views.components.DebtSelect;
	import com.soatech.debtcountdown.views.components.ExpenseEdit;
	import com.soatech.debtcountdown.views.components.ExpenseSelect;
	import com.soatech.debtcountdown.views.components.IncomeEdit;
	import com.soatech.debtcountdown.views.components.IncomeSelect;
	import com.soatech.debtcountdown.views.components.PaymentPlan;
	import com.soatech.debtcountdown.views.components.PlanEdit;
	import com.soatech.debtcountdown.views.components.PlanSelect;
	import com.soatech.debtcountdown.views.components.RunPlan;
	import com.soatech.debtcountdown.views.interfaces.IAppMediator;
	
	import mx.events.ResizeEvent;
	
	public class AppMediator extends AppMediatorBase implements IAppMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():DebtCountDownPhone
		{
			return viewComponent as DebtCountDownPhone;
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
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( view, ResizeEvent.RESIZE, resizeHandler );
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function budget_createSuccessHandler(event:BudgetEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function budget_editBackHandler(event:BudgetEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function budget_editHandler(event:BudgetEvent):void
		{
			switch(event.budgetItem.type)
			{
				case BudgetItemTypes.EXPENSE:
				{
					view.navigator.pushView( ExpenseEdit, event.budgetItem );
					break;
				}
				case BudgetItemTypes.INCOME:
				{
					view.navigator.pushView( IncomeEdit, event.budgetItem );
					break;
				}
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function budget_newBackHandler(event:BudgetEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function budget_selectBackHandler(event:BudgetEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function dataBase_connectedHandler(event:DataBaseEvent):void
		{
			view.navigator.pushView( PlanSelect );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_createSuccessHandler(event:DebtEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_editHandler(event:DebtEvent):void
		{
			view.navigator.pushView( DebtEdit, event.debt );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_editBackHandler(event:DebtEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_newBackHandler(event:DebtEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_newHandler(event:DebtEvent):void
		{
			view.navigator.pushView( DebtEdit, event.debt );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_selectBackHandler(event:DebtEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_selectContinueHandler(event:DebtEvent):void
		{
			view.navigator.pushView( IncomeSelect, event.plan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_showSelectHandler(event:DebtEvent):void
		{
			view.navigator.pushView( DebtSelect, event.plan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function expense_newHandler(event:ExpenseEvent):void
		{
			view.navigator.pushView( ExpenseEdit, event.budgetItem );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function expense_selectContinueHandler(event:ExpenseEvent):void
		{
			view.navigator.pushView( RunPlan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function income_newHandler(event:IncomeEvent):void
		{
			view.navigator.pushView( IncomeEdit, event.budgetItem );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function income_selectContinueHandler(event:IncomeEvent):void
		{
			view.navigator.pushView( ExpenseSelect );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function plan_createSuccessHandler(event:PlanEvent):void
		{
			view.navigator.pushView( DebtSelect, event.plan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function plan_editBackHandler(event:PlanEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function plan_newBackHandler(event:PlanEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function plan_newHandler(event:PlanEvent):void
		{
			view.navigator.pushView( PlanEdit, event.plan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function plan_saveSuccessHandler(event:PlanEvent):void
		{
			view.navigator.pushView( DebtSelect, event.plan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function plan_selectedChangedHandler(event:PlanEvent):void
		{
			view.navigator.pushView( PlanEdit, event.plan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function paymentPlan_backHandler(event:PaymentPlanEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function paymentPlan_showRunHandler(event:PaymentPlanEvent):void
		{
			view.navigator.pushView( RunPlan, event.plan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function paymentPlan_detailsHandler(event:PaymentPlanEvent):void
		{
			view.navigator.pushView( PaymentPlan );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function resizeHandler(event:ResizeEvent):void
		{
			dispatch( new RotateEvent( RotateEvent.ROTATED ) );
		}
	}
}