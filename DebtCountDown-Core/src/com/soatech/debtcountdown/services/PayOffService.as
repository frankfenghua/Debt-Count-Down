package com.soatech.debtcountdown.services
{
	import com.soatech.debtcountdown.models.vo.DebtVO;
	import com.soatech.debtcountdown.models.vo.PaymentPlanVO;
	import com.soatech.debtcountdown.models.vo.StatsVO;
	import com.soatech.debtcountdown.services.interfaces.IPayOffService;
	
	import mx.collections.ArrayCollection;
	
	import spark.collections.Sort;

	public class PayOffService implements IPayOffService
	{
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		public function PayOffService()
		{
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Tries to estimate minimum payment based on APR and balance 
		 * @param debt
		 * @return 
		 * 
		 */		
		public function estimateMinimumPayment(balance:Number):Number
		{
			var retval:Number;
			var rate:Number;
			
			// 3% is the highest I've seen
			rate = 3 / 100;
			
			retval = Math.floor(balance * rate);
			
			return retval;
		}
		
		/**
		 * 
		 * @param debt
		 * @param payment
		 * @return 
		 * 
		 */		
		public function determinePayOffSingle(debt:DebtVO, payment:Number, extra:Number=NaN):StatsVO
		{
			var stats:StatsVO = new StatsVO();
			var interest:Number;
			var principal:Number;
			var rate:Number;
			var balance:Number = debt.balance;
				
			rate = (debt.apr / 100) / 12;
			
			stats.totalInterestPaid = 0;
			
			while( balance > 0 )
			{
				interest = balance * rate;
				principal = payment - interest;
				
				stats.totalInterestPaid += interest;
				
				balance -= principal;
				
				// this is a one time use for when you have a bit extra after 
				// paying off the first card
				if( !isNaN( extra ) && extra > 0 )
				{
					balance -= extra;
					extra = 0;
				}
				
				stats.monthsToPayOff++;
				
				if( balance <= 0 )
					stats.paymentRemaining = balance * -1;
			}
			
			return stats;
		}
		
		/**
		 * 
		 * @param debtList
		 * @param payment
		 * @return 
		 * 
		 */		
		public function determinePayOffMultipleByBalance(debtList:ArrayCollection, payment:Number):StatsVO
		{
			debtList.sort = new Sort();
			debtList.sort.compareFunction = sortByBalance;
			debtList.refresh();
			
			var totalStats:StatsVO = new StatsVO();

			totalStats = payOffDebts(debtList, payment);
			
			return totalStats;
		}
		
		/**
		 * 
		 * @param debtList
		 * @param payment
		 * @return 
		 * 
		 */		
		public function determinePayOffMultipleByRate(debtList:ArrayCollection, payment:Number):StatsVO
		{
			debtList.sort = new Sort();
			debtList.sort.compareFunction = sortByRate;
			debtList.refresh();
			
			var totalStats:StatsVO = new StatsVO();
			
			totalStats = payOffDebts(debtList, payment);
			
			return totalStats;
		}
		
		/**
		 * 
		 * @param debtList
		 * @return 
		 * 
		 */		
		public function determinePayOffMinimumOnly(debtList:ArrayCollection):StatsVO
		{
			var stats:StatsVO = new StatsVO();
			var debt:DebtVO;
			var paidInFull:Boolean;
			var months:int;
			
			var rate:Number;
			var interest:Number;
			var principal:Number;
			var extra:Number;
			var i:int;
			var j:int;
			
			stats.totalInterestPaid = 0;
			
			while( !paidInFull )
			{
				paidInFull = true;
				
				for ( j = 0; j < debtList.length; j++ )
				{
					debt = debtList.getItemAt(j) as DebtVO;
					
					if( debt.balance <= 0 )
						continue;
					
					rate = (debt.apr / 100) / 12;
					
					interest = debt.balance * rate;
					
					principal = debt.minPayment - interest;
					
					debt.balance -= principal;
					
					if( !isNaN( extra ) && extra > 0 )
					{
						debt.balance -= extra;
						extra = 0;
					}
					
					if( debt.balance < 0 )
						extra = debt.balance * -1;
					
					stats.totalInterestPaid += interest;
					
					if( debt.balance > 0 )
						paidInFull = false;
				}
				
				months++;
			}
			
			stats.monthsToPayOff = months;
			
			return stats;
		}
		
		/**
		 * Iterates over current debts and subtracts minimum payments for debts 
		 * still active to see what we have remining to throw towards our focus 
		 * debt
		 *  
		 * @param debtList
		 * @param payment
		 * @return 
		 * 
		 */		
		public function determineRemainderPayment(debtList:ArrayCollection, payment:Number, debt:DebtVO):Number
		{
			var remainderPayment:Number = payment;
			
			for each( var item:DebtVO in debtList)
			{
				if( item.balance > 0 && item.pid != debt.pid)
					remainderPayment -= item.minPayment;
			}
			
			return remainderPayment;
		}
		
		/**
		 * 
		 * @param debtList
		 * @param payment
		 * @return 
		 * 
		 */		
		public function payOffDebts(debtList:ArrayCollection, payment:Number):StatsVO
		{
			var debt:DebtVO;
			var remainderPayment:Number;
			var totalStats:StatsVO = new StatsVO();
			var paidInFull:Boolean;
			var months:int;
			
			var rate:Number;
			var interest:Number;
			var principal:Number;
			var extra:Number;
			var focusDebt:DebtVO;
			var i:int;
			var j:int;
			var paymentPlan:PaymentPlanVO;
			
			totalStats.paymentPlan = new ArrayCollection();
			totalStats.totalInterestPaid = 0;
			
			while( !paidInFull )
			{
				paidInFull = true;
				
				for ( i = 0; i < debtList.length; i++ )
				{
					debt = debtList.getItemAt(i) as DebtVO;
					
					if( debt.balance > 0 )
					{
						focusDebt = debt;
						break;
					}
				}
				
				remainderPayment = determineRemainderPayment(debtList, payment, focusDebt);
				
				for ( j = 0; j < debtList.length; j++ )
				{
					debt = debtList.getItemAt(j) as DebtVO;
					
					if( debt.balance <= 0 )
						continue;
					
					paymentPlan = new PaymentPlanVO();
					paymentPlan.debt = debt;
					paymentPlan.balance = debt.balance;
					paymentPlan.month = months;
					
					rate = (debt.apr / 100) / 12;
					
					interest = debt.balance * rate;
					
					if( debt.pid == focusDebt.pid )
					{
						paymentPlan.payment = (remainderPayment > debt.balance) ? debt.balance : remainderPayment;
						principal = remainderPayment - interest;
					}
					else
					{
						paymentPlan.payment = (debt.minPayment > debt.balance) ? debt.balance : debt.minPayment;
						principal = debt.minPayment - interest;
					}
					
					debt.balance -= principal;
					
					if( !isNaN( extra ) && extra > 0 )
					{
						paymentPlan.payment += extra;
						debt.balance -= extra;
						extra = 0;
					}
					
					if( debt.balance < 0 )
						extra = debt.balance * -1;
					
					totalStats.totalInterestPaid += interest;
					
					if( debt.balance > 0 )
						paidInFull = false;
					
					totalStats.paymentPlan.addItem( paymentPlan );
				}
				
				months++;
			}

			totalStats.monthsToPayOff = months;
			
			return totalStats;
		}
		
		/**
		 * Sorts the collection based on balance 
		 * @param a
		 * @param b
		 * @return 
		 * 
		 */		
		public function sortByBalance(a:DebtVO, b:DebtVO, fields:Array = null):int
		{
			if( a.balance < b.balance )
				return -1;
			else if ( a.balance > b.balance )
				return 1;
			
			return 0;
		}
		
		/**
		 * 
		 * @param a
		 * @param b
		 * @param fields
		 * @return 
		 * 
		 */		
		public function sortByRate(a:DebtVO, b:DebtVO, fields:Array = null):int
		{
			if( a.apr < b.apr )
				return 1;
			else if( a.apr > b.apr )
				return -1;
			
			return 0;
		}
	}
}