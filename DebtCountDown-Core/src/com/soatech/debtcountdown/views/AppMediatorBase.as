package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.ExpenseEvent;
	import com.soatech.debtcountdown.events.IncomeEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.views.interfaces.IAppMediator;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AppMediatorBase extends Mediator implements IAppMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( BudgetEvent.CREATE_SUCCESS, budget_createSuccessHandler );
			addContextListener( BudgetEvent.EDIT, budget_editHandler );
			addContextListener( BudgetEvent.EDIT_BACK, budget_editBackHandler );
			addContextListener( BudgetEvent.NEW_BACK, budget_newBackHandler );
			addContextListener( BudgetEvent.SELECT_BACK, budget_selectBackHandler );
			
			addContextListener( DataBaseEvent.CONNECTED, dataBase_connectedHandler );
			
			addContextListener( DebtEvent.CREATE_SUCCESS, debt_createSuccessHandler );
			addContextListener( DebtEvent.EDIT, debt_editHandler );
			addContextListener( DebtEvent.EDIT_BACK, debt_editBackHandler );
			addContextListener( DebtEvent.NEW_BACK, debt_newBackHandler );
			addContextListener( DebtEvent.NEW_DEBT, debt_newHandler );
			addContextListener( DebtEvent.SELECT_BACK, debt_selectBackHandler );
			addContextListener( DebtEvent.SELECT_CONTINUE, debt_selectContinueHandler );
			addContextListener( DebtEvent.SHOW_SELECT, debt_showSelectHandler );
			
			addContextListener( ExpenseEvent.NEW_EXPENSE, expense_newHandler );
			addContextListener( ExpenseEvent.SELECT_CONTINUE, expense_selectContinueHandler );
			
			addContextListener( IncomeEvent.NEW_INCOME, income_newHandler );
			addContextListener( IncomeEvent.SELECT_CONTINUE, income_selectContinueHandler );
			
			addContextListener( PaymentPlanEvent.BACK, paymentPlan_backHandler );
			addContextListener( PaymentPlanEvent.SHOW_RUN, paymentPlan_showRunHandler );
			addContextListener( PaymentPlanEvent.DETAILS, paymentPlan_detailsHandler );
			
			addContextListener( PlanEvent.CREATE_SUCCESS, plan_createSuccessHandler );
			addContextListener( PlanEvent.EDIT_BACK, plan_editBackHandler );
			addContextListener( PlanEvent.NEW_BACK, plan_newBackHandler );
			addContextListener( PlanEvent.NEW_PLAN, plan_newHandler );
			addContextListener( PlanEvent.SAVE_SUCCESS, plan_saveSuccessHandler );
			addContextListener( PlanEvent.SELECTED_CHANGED, plan_selectedChangedHandler );
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		public function budget_createSuccessHandler(event:BudgetEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::income_createSuccessHandler" ); };
		}
		
		public function budget_editBackHandler(event:BudgetEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::income_editBackHandler" ); };
		}
		
		public function budget_editHandler(event:BudgetEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::income_editHandler" ); };
		}
		
		public function budget_newBackHandler(event:BudgetEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::income_newBackHandler" ); };
		}
		
		public function budget_selectBackHandler(event:BudgetEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::income_selectBackHandler" ); };
		}
		
		public function dataBase_connectedHandler(event:DataBaseEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::dataBase_connectedHandler"); };
		}
		
		public function debt_createSuccessHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::debt_createSuccessHandler"); };
		}
		
		public function debt_editHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::debt_editHandler"); };
		}
		
		public function debt_editBackHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::debt_editBackHandler"); };
		}
		
		public function debt_newBackHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::debt_newBackHandler"); };
		}
		
		public function debt_newHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::debt_newHandler"); };
		}
		
		public function debt_selectBackHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::debt_selectBackHandler"); };
		}
		
		public function debt_selectContinueHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::debt_selectContinueHandler" ); };
		}
		
		public function debt_showSelectHandler(event:DebtEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::debt_showSelectHandler"); };
		}
		
		public function expense_newHandler(event:ExpenseEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::expense_newHandler" ); };
		}
		
		public function expense_selectContinueHandler(event:ExpenseEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::expense_selectContinueHandler" ); };
		}
		
		public function income_newHandler(event:IncomeEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::income_newHandler" ); };
		}
		
		public function income_selectContinueHandler(event:IncomeEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::income_selectContinueHandler" ); };
		}
		
		public function plan_createSuccessHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::plan_createSuccessHandler"); };
		}
		
		public function plan_editBackHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::plan_editBackHandler"); };
		}
		
		public function plan_newBackHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::plan_newBackHandler"); };
		}
		
		public function plan_newHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::plan_newHandler"); };
		}
		
		public function plan_saveSuccessHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::plan_saveSuccessHandler" ); };
		}
		
		public function plan_selectedChangedHandler(event:PlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::plan_selectedChangedHandler"); };
		}
		
		public function paymentPlan_backHandler(event:PaymentPlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::paymentPlan_backHandler"); };
		}
		
		public function paymentPlan_showRunHandler(event:PaymentPlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::paymentPlan_showRunHandler"); };
		}
		
		public function paymentPlan_detailsHandler(event:PaymentPlanEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::paymentPlan_detailsHandler"); };
		}
	}
}