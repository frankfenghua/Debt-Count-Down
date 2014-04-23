package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.enum.RoutineType;
	import com.soatech.debtcountdown.events.PaymentPlanEvent;
	import com.soatech.debtcountdown.models.StatsProxy;
	import com.soatech.debtcountdown.models.vo.PaymentPlanVO;
	import com.soatech.debtcountdown.views.interfaces.IPaymentPlan;
	import com.soatech.debtcountdown.views.interfaces.IPaymentPlanMediator;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class PaymentPlanMediatorBase extends Mediator implements IPaymentPlanMediator
	{
		[Inject]
		public var statsProxy:StatsProxy;
		
		public function get view():IPaymentPlan
		{
			return viewComponent as IPaymentPlan;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			view.backBtn.addEventListener(MouseEvent.CLICK, backBtn_clickHandler);
			
			setup();
		}
		
		public function setup():void
		{
			var list:ArrayCollection = new ArrayCollection();
			var i:int = 0;
			var paymentPlan:PaymentPlanVO;
			var month:int;
			
			switch( statsProxy.selectedRoutine )
			{
				case RoutineType.BALANCE:
				{
					view.title = "Lowest Balance (6 mo.)";
					i=0;
					do
					{
						paymentPlan = statsProxy.balanceStats.paymentPlan.getItemAt(i) as PaymentPlanVO;
						
						if( month != paymentPlan.month || !list.length)
						{
							list.addItem({name: "Month " + (paymentPlan.month + 1).toString(), payment: ""});
							
							month = paymentPlan.month;
						}
						
						list.addItem({name: paymentPlan.debt.name, payment: paymentPlan.payment.toFixed(2)});
						
						i++;
					} while( paymentPlan.month < 6 && i < statsProxy.balanceStats.paymentPlan.length );
					break;
				}
				case RoutineType.RATE:
				{
					view.title = "Highest Rate (6 mo.)";
					i=0;
					do
					{
						paymentPlan = statsProxy.rateStats.paymentPlan.getItemAt(i) as PaymentPlanVO;
						
						if( month != paymentPlan.month || !list.length)
						{
							list.addItem({name: "Month " + (paymentPlan.month + 1).toString(), payment: ""});
							
							month = paymentPlan.month;
						}
						
						list.addItem({name: paymentPlan.debt.name, payment: paymentPlan.payment.toFixed(2)});
						
						i++;
					} while( paymentPlan.month < 6 && i < statsProxy.rateStats.paymentPlan.length );
					
					break;
				}
			}
			
			list.removeItemAt(list.length - 1); // nature of do...while
			list.removeItemAt(list.length - 1); // nature of do...while
			view.actionList.dataProvider = list;
		}
		
		public function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new PaymentPlanEvent( PaymentPlanEvent.BACK ) );
		}
	}
}