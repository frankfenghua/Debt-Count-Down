package com.soatech.debtcountdown.helpers
{
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;

	public class ELSHelper
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public function get isSupported():Boolean
		{
			return EncryptedLocalStore.isSupported;
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves encrypted key from ELS. Creates one if one doesn't exist. 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getEncryptedKey(id:String):ByteArray
		{
			if( !EncryptedLocalStore.isSupported )
				throw Error("ELS Not Supported");
			
			var key:ByteArray;
			
			// pull key from ELS
			key = EncryptedLocalStore.getItem(id);
			
			if( !key )
			{
				// create a key if one doesn't exist
				key = PasswordHelper.getEncryptionKey(PasswordHelper.randomPassword());
				EncryptedLocalStore.setItem(id, key);
			}
			
			return key;
		}
	}
}