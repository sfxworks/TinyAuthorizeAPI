package net.sfxworks.tinyauthorizeapi.events 
{
	import flash.events.Event;
	import net.sfxworks.tinyauthorizeapi.definitions.CustomerProfile;
	
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class ProfilerEvent extends Event 
	{
		public static const SUCCESS:String = "profsuccess";
		public static const ERROR:String = "profError";
		private var _profile:CustomerProfile;
		
		public function ProfilerEvent(type:String, profile:CustomerProfile=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_profile = profile;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ProfilerEvent(type, _profile, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ProfilerEvent", "type", "profile", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get profile():CustomerProfile 
		{
			return _profile;
		}
		
	}
	
}