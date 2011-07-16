package com.soatech.debtcountdown.views.interfaces
{
	import mx.containers.ViewStack;
	import mx.core.IUIComponent;

	public interface IMainView extends IUIComponent
	{
		function get mainStack():ViewStack;
	}
}