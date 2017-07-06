package net.sfxworks.tinyauthorizeapi 
{
	import net.sfxworks.tinyauthorizeapi.definitions.AuthorizeNetMode;
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class AuthorizeNetCore 
	{
		private var login:String;
		private var transactKey:String;
		
		private var _charger:Charger;
		private var _cart:Cart;
		private var _profiler:Profiler;
		
		public function AuthorizeNetCore() 
		{
			trace("Test");
		}
		
		public function init(login:String, transactionKey:String, mode:String="https://apitest.authorize.net/xml/v1/request.api"):void
		{
			login = login;
			transactKey = transactionKey;
			_charger = new Charger(login, transactionKey, mode);
			_profiler = new Profiler(login, transactionKey, mode);
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
		
		public function get profiler():Profiler 
		{
			return _profiler;
		}
		
	}

}