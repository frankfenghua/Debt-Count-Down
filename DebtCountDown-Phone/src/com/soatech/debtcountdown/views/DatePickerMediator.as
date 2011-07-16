package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.DatePickerEvent;
	import com.soatech.debtcountdown.views.components.DatePicker;
	import com.soatech.debtcountdown.views.components.DropDownList;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.IndexChangedEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class DatePickerMediator extends Mediator implements IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():DatePicker
		{
			return viewComponent as DatePicker;
		}

		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var dayList:ArrayCollection;
		protected var dropDownList:DropDownList;
		protected var monthList:ArrayCollection;
		protected var yearList:ArrayCollection;
		
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
			
			eventMap.mapListener( view.dayBtn, MouseEvent.CLICK, dayBtn_clickHandler );
			eventMap.mapListener( view.monthBtn, MouseEvent.CLICK, monthBtn_clickHandler );
			eventMap.mapListener( view.yearBtn, MouseEvent.CLICK, yearBtn_clickHandler );
			eventMap.mapListener( view, DatePickerEvent.DATE_CHANGE, date_changeHandler );
			
			populate();
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
		public function populate():void
		{
			var i:int;
			var currentDate:Date = new Date();
			var topYear:int;
			var bottomYear:int;
			
			// setup drop downs
			dayList = new ArrayCollection();
			for( i = 1; i <= 31; i++ )
				dayList.addItem( i );
			
			monthList = new ArrayCollection();
			for( i = 1; i <= 12; i++ )
				monthList.addItem( i );
			
			topYear = currentDate.fullYear + 30;
			bottomYear = currentDate.fullYear - 100;
			
			yearList = new ArrayCollection();
			for( i = bottomYear; i <= topYear; i++ )
				yearList.addItem( i );
			
			if( view.date )
			{
				view.dayBtn.label = view.date.date.toString();
				view.monthBtn.label = (view.date.month + 1).toString();
				view.yearBtn.label = view.date.fullYear.toString();
				
				validateDate();
			}
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		protected function validateDate():Boolean
		{
			var retval:Boolean = true;
			var date:Date;
			
			date = new Date( int(view.yearBtn.label), int(view.monthBtn.label)-1, int(view.dayBtn.label) );
			
			view.dayBtnValidator.validate();
			view.monthBtnValidator.validate();
			view.yearBtnValidator.validate();
			
			if( date.fullYear != int(view.yearBtn.label) )
			{
				view.yearBtnValidator.validate("NaN");
				retval = false;
				trace("years don't match");
			}
			
			if( date.date != int( view.dayBtn.label ) )
			{
				view.dayBtnValidator.validate("NaN");
				retval = false;
				trace("days don't match");
			}
			
			if( date.month != int( view.monthBtn.label )-1 )
			{
				view.monthBtnValidator.validate("NaN");
				retval = false;
				trace("months don't match");
			}
			
			if( retval )
				view.dispatchEvent( new DatePickerEvent( DatePickerEvent.DATE_VALID, date ) );
			else
				view.dispatchEvent( new DatePickerEvent( DatePickerEvent.DATE_INVALID, date ) );
			
			return retval;
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
		protected function date_changeHandler(event:DatePickerEvent):void
		{
			populate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function dayBtn_clickHandler(event:MouseEvent):void
		{
			dropDownList = new DropDownList();
			dropDownList.dataProvider = dayList;
			dropDownList.addEventListener( IndexChangedEvent.CHANGE, dropDownList_dayChangeHandler );
			dropDownList.open(view);
			
			this.mediatorMap.createMediator(dropDownList);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function dropDownList_dayChangeHandler(event:IndexChangeEvent):void
		{
			view.dayBtn.label = dayList.getItemAt(event.newIndex).toString();
			dropDownList.removeEventListener( IndexChangeEvent.CHANGE, dropDownList_dayChangeHandler );
			dropDownList.close();
			
			validateDate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function dropDownList_monthChangeHandler(event:IndexChangeEvent):void
		{
			view.monthBtn.label = monthList.getItemAt(event.newIndex).toString();
			dropDownList.removeEventListener( IndexChangeEvent.CHANGE, dropDownList_monthChangeHandler );
			dropDownList.close();
			
			validateDate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function dropDownList_yearChangeHandler(event:IndexChangeEvent):void
		{
			view.yearBtn.label = yearList.getItemAt(event.newIndex).toString();
			dropDownList.removeEventListener( IndexChangeEvent.CHANGE, dropDownList_yearChangeHandler );
			dropDownList.close();
			
			validateDate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function monthBtn_clickHandler(event:MouseEvent):void
		{
			dropDownList = new DropDownList();
			dropDownList.dataProvider = monthList;
			dropDownList.addEventListener( IndexChangeEvent.CHANGE, dropDownList_monthChangeHandler );
			dropDownList.open(view);
			
			this.mediatorMap.createMediator(dropDownList);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function yearBtn_clickHandler(event:MouseEvent):void
		{
			dropDownList = new DropDownList();
			dropDownList.dataProvider = yearList;
			dropDownList.addEventListener( IndexChangeEvent.CHANGE, dropDownList_yearChangeHandler );
			dropDownList.open(view);
			
			this.mediatorMap.createMediator(dropDownList);
		}
	}
}