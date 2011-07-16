package com.soatech.debtcountdown.helpers
{
	import com.adobe.air.crypto.EncryptionKeyGenerator;
	
	import flash.utils.ByteArray;
	
	import mx.utils.UIDUtil;

	public class PasswordHelper
	{
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected static const LOWER:String = "abcdefghijklmnopqrstuvwxyz";
		protected static const DEFAULT_LENGTH:int = 32;
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param length
		 * @return 
		 * 
		 */		
		public static function randomPassword():String
		{
			var password:String;
			var number:int;
			var lower:String;
			var length:int;

			length = DEFAULT_LENGTH;
			
			password = UIDUtil.createUID();
			
			number = Math.random() * 10;
			
			lower = LOWER.substr(number, 1);
			
			return password.substr(0, length-1)+lower;
		}
		
		/**
		 * 
		 * @param password
		 * @return 
		 * 
		 */		
		public static function getEncryptionKey(password:String):ByteArray
		{
			var key:ByteArray;
			var keyGen:EncryptionKeyGenerator = new EncryptionKeyGenerator();
			key = keyGen.getEncryptionKey(password);
			
			return key;
		}
	}
}