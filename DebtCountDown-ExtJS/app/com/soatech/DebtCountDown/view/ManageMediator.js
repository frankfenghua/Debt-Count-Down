Ext.namespace('DebtCountDown.view');
DebtCountDown.view.ManageMediator = Ext.extend(Puremvc.patterns.Mediator, {

	view: null,
	
	debtProxy: null,
	
	planProxy: null,

	constructor: function(viewComponent /* Manage */)
	{
		DebtCountDown.view.ManageMediator.superclass.constructor.call(this, DebtCountDown.view.ManageMediator.NAME, viewComponent);
		this.view = this.getViewComponent();
	},
	
	listNotificationInterests: function()
	{
		return [
			DebtCountDown.model.DebtProxy.LIST_CHANGED,
			DebtCountDown.model.PlanProxy.LIST_CHANGED
		];
	},
	
	handleNotification: function(notification)
	{
		switch( notification.getName() )
		{
			case DebtCountDown.model.DebtProxy.LIST_CHANGED:
				this.view.setDebtStore(notification.getBody());
				break;
			case DebtCountDown.model.PlanProxy.LIST_CHANGED:
				this.view.setPlanStore(notification.getBody());
				break;
		}
	},
	
	onRegister: function()
	{
		DebtCountDown.view.ManageMediator.superclass.onRegister.call(this);
		
		this.debtProxy = this.facade.retrieveProxy(DebtCountDown.model.DebtProxy.NAME);
		this.planProxy = this.facade.retrieveProxy(DebtCountDown.model.PlanProxy.NAME);
		
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		this.debtProxy.addDebt(new DebtCountDown.model.vo.DebtVO(1, 0, 'Debt One', 'Bank', 12345, 12.345, 350));
		this.planProxy.addPlan(new DebtCountDown.model.vo.PlanVO(1, 6000, 8000, 'Plan One'));
		
		this.view.setDebtStore(this.debtProxy.debtList);
	},
	
	onRemove: function()
	{
		DebtCountDown.view.ManageMediator.superclass.onRemove.call(this);
	},

	
});

Ext.apply(DebtCountDown.view.ManageMediator, 
{
	NAME: "ManageMediator"	
});