package com.soatech.debtcountdown.models.interfaces
{
	public interface IToggleAble
	{
		function get name():String;
		function get active():Boolean;
		function set active(value:Boolean):void;
	}
}