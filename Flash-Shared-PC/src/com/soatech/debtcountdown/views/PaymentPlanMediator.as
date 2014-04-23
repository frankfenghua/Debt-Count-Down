package com.soatech.debtcountdown.views
{
	import com.soatech.debtcountdown.events.MainStackEvent;
	import com.soatech.debtcountdown.views.interfaces.IPaymentPlanMediator;
	
	public class PaymentPlanMediator extends PaymentPlanMediatorBase implements IPaymentPlanMediator
	{
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( eventDispatcher, MainStackEvent.SWITCH_PAYMENT_PLAN, mainStack_switchHandler);
		}
		
		protected function mainStack_switchHandler(event:MainStackEvent):void
		{
			setup();
		}
	}
}