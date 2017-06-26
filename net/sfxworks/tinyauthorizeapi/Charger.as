package net.sfxworks.tinyauthorizeapi 
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class Charger extends EventDispatcher
	{
		
		private var log:String;
		private var tK:String;
		
		public function Charger(login:String, transactKey:String) 
		{
			log = login;
			tK = transactKey;
		}
		
		public function chargeCard(card:Card, total:Number):void
		{
			
		}
		
		public function chargeProfile(profile:CustomerProfile, total:Number):void
		{
			
		}
		
	}

}