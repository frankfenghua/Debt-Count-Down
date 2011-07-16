package com.soatech.debtcountdown.models
{
	import com.soatech.debtcountdown.models.vo.StatsVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class StatsProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var balanceStats:StatsVO;
		public var rateStats:StatsVO;
		public var minStats:StatsVO;
		public var selectedRoutine:String;
	}
}