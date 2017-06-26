package net.sfxworks.tinyauthorizeapi 
{
	import net.sfxworks.tinyauthorizeapi.definitions.Card;
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class Profiler extends Communicator 
	{
		
		public function Profiler(login:String, transactKey:String, mode:String) 
		{
			super(login, transactKey, mode);
			
		}
		
		public function createProfile(card:Card):void
		{
			
		}
		
	}

}