package net.sfxworks.tinyauthorizeapi 
{
	import net.sfxworks.tinyauthorizeapi.definitions.AuthorizeNetMode;
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class Core 
	{
		private var login:String;
		private var transactKey:String;
		
		private var _charger:Charger;
		private var _cart:Cart;
		
		public function Core() 
		{
			
		}
		
		public function init(login:String, transactionKey:String, mode:String=AuthorizeNetMode.SANDBOX):void
		{
			login = login;
			transactKey = transactionKey;
			_charger = new Charger(login, transactionKey, mode);
			_cart = new Cart();
		}
		
		public function get charger():Charger 
		{
			return _charger;
		}
		
		public function get cart():Cart 
		{
			return _cart;
		}
		
	}

}