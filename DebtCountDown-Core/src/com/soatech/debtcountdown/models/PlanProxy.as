package com.soatech.debtcountdown.models
{
	import com.soatech.debtcountdown.events.PlanEvent;
	import com.soatech.debtcountdown.models.vo.PlanVO;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PlanProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// planList
		//-----------------------------
		
		private var _planList:ArrayCollection;

		public function get planList():ArrayCollection
		{
			return _planList;
		}

		public function set planList(value:ArrayCollection):void
		{
			_planList = value;
			
			dispatch( new PlanEvent( PlanEvent.LIST_CHANGED, null, _planList ) );
		}

		
		//-----------------------------
		// selectedPlan
		//-----------------------------
		
		private var _selectedPlan:PlanVO;

		public function get selectedPlan():PlanVO
		{
			return _selectedPlan;
		}

		public function set selectedPlan(value:PlanVO):void
		{
			_selectedPlan = value;
			
			dispatch( new PlanEvent( PlanEvent.SELECTED_CHANGED, _selectedPlan ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function addPlan(plan:PlanVO):void
		{
			if( !_planList )
				_planList = new ArrayCollection();
			
			_planList.addItem(plan);
			
			dispatch( new PlanEvent( PlanEvent.LIST_CHANGED, null, _planList ) );
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function removePlan(plan:PlanVO):void
		{
			if( !_planList )
				return;
			
			for( var i:int = 0; i < _planList.length; i++ )
			{
				if( (_planList.getItemAt(i) as PlanVO).pid == plan.pid )
					_planList.removeItemAt(i);
			}
			
			dispatch( new PlanEvent( PlanEvent.LIST_CHANGED, null, _planList ) );
		}
		
		/**
		 * 
		 * @param plan
		 * 
		 */		
		public function replacePlan(plan:PlanVO):void
		{
			if( !_planList )
				return;
			
			for( var i:int = 0; i < _planList.length; i++ )
			{
				if( (_planList.getItemAt(i) as PlanVO).pid == plan.pid )
					_planList.setItemAt(plan, i);
			}
			
			dispatch( new PlanEvent( PlanEvent.LIST_CHANGED, null, _planList ) );
		}
	}
}