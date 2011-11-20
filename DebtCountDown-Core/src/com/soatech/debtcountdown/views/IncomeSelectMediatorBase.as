package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.BudgetEvent;
	import com.soatech.debtcountdown.events.IncomeEvent;
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
			eventMap.mapListener( view.incomeList, IndexChangeEvent.CHANGE, incomeList_selectHandler );
			
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
				view.instructions.visible = false;
			}
			else
			{
				view.contBtn.enabled = false;
				view.instructions.visible = true;
			}
			
			view.incomeList.dataProvider = biProxy.incomeList;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function incomeList_selectHandler(event:IndexChangeEvent):void
		{
			var income:BudgetItemVO = view.incomeList.selectedItem as BudgetItemVO;
			
			if( income )
			{
				dispatch( new BudgetEvent( BudgetEvent.SELECT, income ) );
				dispatch( new BudgetEvent( BudgetEvent.EDIT, income ) );
			}
		}
	}
}