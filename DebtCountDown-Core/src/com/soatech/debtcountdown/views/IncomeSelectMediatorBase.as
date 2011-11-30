package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.IncomeEvent;
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.events.SelectToggleEvent;
	import com.soatech.debtcountdown.models.BudgetItemProxy;
	import com.soatech.debtcountdown.models.vo.BudgetItemVO;
	import com.soatech.debtcountdown.views.interfaces.IIncomeSelect;
	import com.soatech.debtcountdown.views.interfaces.IIncomeSelectMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class IncomeSelectMediatorBase extends Mediator implements IMediator, IIncomeSelectMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var biProxy:BudgetItemProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():IIncomeSelect
		{
			return viewComponent as IIncomeSelect;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------

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
			
			// context listeners
			addContextListener( BudgetEvent.LIST_CHANGED, incomeList_changeHandler );
			
			// view listeners
			eventMap.mapListener( view.addBtn, MouseEvent.CLICK, addBtn_clickHandler );
			eventMap.mapListener( view.backBtn, MouseEvent.CLICK, backBtn_clickHandler );
			eventMap.mapListener( view.contBtn, MouseEvent.CLICK, contBtn_clickHandler );
			eventMap.mapListener( view.incomeList, SelectToggleEvent.EDIT, incomeList_selectEditHandler );
			eventMap.mapListener( view.incomeList, SelectToggleEvent.TOGGLE, incomeList_selectToggleHandler );
			
			setup();
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * 
		 */
		public function setup():void
		{
			dispatch( new BudgetEvent( BudgetEvent.LOAD_ALL ) );
		}
		
		/**
		 * 
		 * 
		 */
		public function verifyToggles():void
		{
			// check to see if any are select
			var enabled:Boolean = false;
			for each( var item:BudgetItemVO in view.incomeList.dataProvider )
			{
				if( item.active )
					enabled = true;
			}
			
			view.contBtn.enabled = enabled;
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
		public function addBtn_clickHandler(event:MouseEvent):void
		{
			var budgetItem:BudgetItemVO = new BudgetItemVO();
			
			dispatch( new BudgetEvent( BudgetEvent.SELECT, budgetItem ) );
			dispatch( new IncomeEvent( IncomeEvent.NEW_INCOME ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new BudgetEvent( BudgetEvent.SELECT_BACK ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function contBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new IncomeEvent( IncomeEvent.SELECT_CONTINUE ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function incomeList_changeHandler(event:BudgetEvent):void
		{
			if( biProxy.incomeList.length )
			{
				view.contBtn.enabled = true;
				view.addInstructions.visible = false;
			}
			else
			{
				view.contBtn.enabled = false;
				view.addInstructions.visible = true;
			}
			
			view.incomeList.dataProvider = biProxy.incomeList;
			
			verifyToggles();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function incomeList_selectEditHandler(event:SelectToggleEvent):void
		{
			var income:BudgetItemVO = event.data as BudgetItemVO;
			
			dispatch( new BudgetEvent( BudgetEvent.SELECT, income ) );
			dispatch( new BudgetEvent( BudgetEvent.EDIT, income ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function incomeList_selectToggleHandler(event:SelectToggleEvent):void
		{
			// dispatch event to update the DB and link the debt to the plan
			if( (event.data as BudgetItemVO).active )
				dispatch( new PlanEvent( PlanEvent.LINK_BUDGET_ITEM, null, null, null, event.data as BudgetItemVO) );
			else
				dispatch( new PlanEvent( PlanEvent.UNLINK_BUDGET_ITEM, null, null, null, event.data as BudgetItemVO) );
			
			verifyToggles();
		}
	}
}