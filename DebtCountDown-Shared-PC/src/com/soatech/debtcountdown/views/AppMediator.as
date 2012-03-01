package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.BudgetItemTypes;
	import com.soatech.debtcountdown.enum.MainStackIndexes;
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.DataBaseEvent;
	import com.soatech.debtcountdown.events.DebtEvent;
	import com.soatech.debtcountdown.events.ExpenseEvent;
	import com.soatech.debtcountdown.events.IncomeEvent;
	import com.soatech.debtcountdown.events.MainStackEvent;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.BudgetItemProxy;
	import com.soatech.debtcountdown.models.DebtProxy;
	import com.soatech.debtcountdown.models.PlanProxy;
	import com.soatech.debtcountdown.views.components.PlanEdit;
	import com.soatech.debtcountdown.views.interfaces.IAppMediator;
	import com.soatech.debtcountdown.views.interfaces.IPCApplication;
	
	import mx.events.FlexEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class AppMediator extends AppMediatorBase implements IAppMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var debtProxy:DebtProxy;
		
		[Inject]
		public var budgetItemProxy:BudgetItemProxy;
		
		[Inject]
		public var planProxy:PlanProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IPCApplication
		{
			return viewComponent as IPCApplication;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var stackHistory:Vector.<String>;
		
		protected var currentStack:String;
		
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
			
			addContextListener( MainStackEvent.SWITCH_DEBT_EDIT, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_DEBT_SELECT, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_EXPENSE_EDIT, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_EXPENSE_SELECT, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_INCOME_EDIT, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_INCOME_SELECT, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_PAYMENT_PLAN, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_PLAN_EDIT, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_PLAN_SELECT, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_RUN_PLAN, mainStack_switchHandler );
			addContextListener( MainStackEvent.SWITCH_SPLASH, mainStack_switchHandler );
			
			stackHistory = new Vector.<String>();
			currentStack = MainStackEvent.SWITCH_SPLASH;
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param type
		 * 
		 */		
		protected function changeView(type:String):void
		{
			stackHistory.push(currentStack);
			dispatch( new MainStackEvent( type ) );
		}
		
		/**
		 * 
		 * 
		 */		
		protected function goBackView():void
		{
			dispatch( new MainStackEvent( stackHistory.pop() ) );
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
			budgetItemProxy.selectedItem = null;
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function budget_editBackHandler(event:BudgetEvent):void
		{
			budgetItemProxy.selectedItem = null;
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function budget_editHandler(event:BudgetEvent):void
		{
			budgetItemProxy.selectedItem = event.budgetItem;
			
			switch( event.budgetItem.type )
			{
				case BudgetItemTypes.EXPENSE:
					changeView(MainStackEvent.SWITCH_EXPENSE_EDIT);
					break;
				case BudgetItemTypes.INCOME:
					changeView(MainStackEvent.SWITCH_INCOME_EDIT);
					break;
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function budget_selectBackHandler(event:BudgetEvent):void
		{
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function dataBase_connectedHandler(event:DataBaseEvent):void
		{
			changeView(MainStackEvent.SWITCH_PLAN_SELECT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function debt_createSuccessHandler(event:DebtEvent):void
		{
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function debt_editHandler(event:DebtEvent):void
		{
			debtProxy.selectedDebt = event.debt;
			changeView(MainStackEvent.SWITCH_DEBT_EDIT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function debt_editBackHandler(event:DebtEvent):void
		{
			debtProxy.selectedDebt = null;
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function debt_newBackHandler(event:DebtEvent):void
		{
			debtProxy.selectedDebt = null;
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function debt_newHandler(event:DebtEvent):void
		{
			debtProxy.selectedDebt = event.debt;
			changeView(MainStackEvent.SWITCH_DEBT_EDIT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function debt_selectBackHandler(event:DebtEvent):void
		{
			debtProxy.selectedDebt = null;
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function debt_selectContinueHandler(event:DebtEvent):void
		{
			changeView(MainStackEvent.SWITCH_INCOME_SELECT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function debt_showSelectHandler(event:DebtEvent):void
		{
			debtProxy.selectedDebt = event.debt;
			changeView(MainStackEvent.SWITCH_DEBT_SELECT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function expense_newHandler(event:ExpenseEvent):void
		{
			budgetItemProxy.selectedItem = event.budgetItem;
			changeView(MainStackEvent.SWITCH_EXPENSE_EDIT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function expense_selectContinueHandler(event:ExpenseEvent):void
		{
			changeView(MainStackEvent.SWITCH_RUN_PLAN);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function income_newHandler(event:IncomeEvent):void
		{
			budgetItemProxy.selectedItem = event.budgetItem;
			changeView(MainStackEvent.SWITCH_INCOME_EDIT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function income_selectContinueHandler(event:IncomeEvent):void
		{
			changeView(MainStackEvent.SWITCH_EXPENSE_SELECT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function mainStack_switchHandler(event:MainStackEvent):void
		{
			switch( event.type )
			{
				case MainStackEvent.SWITCH_DEBT_EDIT:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.DEBT_EDIT;
					break;
				}
				case MainStackEvent.SWITCH_DEBT_SELECT:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.DEBT_SELECT;
					break;
				}
				case MainStackEvent.SWITCH_PLAN_SELECT:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.PLAN_SELECT;
					break;
				}
				case MainStackEvent.SWITCH_PLAN_EDIT:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.PLAN_EDIT;
					break;
				}
				case MainStackEvent.SWITCH_RUN_PLAN:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.RUN_PLAN;
					break;
				}
				case MainStackEvent.SWITCH_PAYMENT_PLAN:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.PAYMENT_PLAN;
					break;
				}
				case MainStackEvent.SWITCH_SPLASH:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.SPLASH;
					break;
				}
				case MainStackEvent.SWITCH_EXPENSE_EDIT:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.EXPENSE_EDIT;
					break;
				}
				case MainStackEvent.SWITCH_EXPENSE_SELECT:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.EXPENSE_SELECT;
					break;
				}
				case MainStackEvent.SWITCH_INCOME_EDIT:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.INCOME_EDIT;
					break;
				}
				case MainStackEvent.SWITCH_INCOME_SELECT:
				{
					view.mainView.mainStack.selectedIndex = MainStackIndexes.INCOME_SELECT;
					break;
				}
			}
			
			currentStack = event.type;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function plan_createSuccessHandler(event:PlanEvent):void
		{
			planProxy.selectedPlan = event.plan;
			changeView(MainStackEvent.SWITCH_DEBT_SELECT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function plan_editBackHandler(event:PlanEvent):void
		{
			planProxy.selectedPlan = null;
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function plan_newBackHandler(event:PlanEvent):void
		{
			planProxy.selectedPlan = null;
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function plan_saveSuccessHandler(event:PlanEvent):void
		{
			planProxy.selectedPlan = event.plan;
			changeView(MainStackEvent.SWITCH_DEBT_SELECT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function plan_selectedChangedHandler(event:PlanEvent):void
		{
			if( planProxy.selectedPlan )
				changeView(MainStackEvent.SWITCH_PLAN_EDIT);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function paymentPlan_backHandler(event:PaymentPlanEvent):void
		{
			goBackView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function paymentPlan_showRunHandler(event:PaymentPlanEvent):void
		{
			changeView(MainStackEvent.SWITCH_RUN_PLAN);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function paymentPlan_detailsHandler(event:PaymentPlanEvent):void
		{
			changeView(MainStackEvent.SWITCH_PAYMENT_PLAN);
		}
		
	}
}