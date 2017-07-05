package test 
{
	import flash.display.Sprite;
	import net.sfxworks.tinyauthorizeapi.AuthorizeNetCore;
	import net.sfxworks.tinyauthorizeapi.definitions.Card;
	import net.sfxworks.tinyauthorizeapi.events.ProfilerEvent;
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class Main extends Sprite
	{
		private var authCore:AuthorizeNetCore;
		public function Main() 
		{
			authCore = new AuthorizeNetCore();
			authCore.init("LOGIN", "KEY");
			authCore.profiler.addEventListener(ProfilerEvent.SUCCESS, handleProfileSuccess);
			authCore.profiler.addEventListener(ProfilerEvent.ERROR, handleProfilerError);
			authCore.profiler.createProfile(new Card("4179470003649334", "12/20", "111"), "individual", "autogen");
			
		}
		
		private function handleProfilerError(e:ProfilerEvent):void 
		{
			trace("Creation error.");
		}
		
		private function handleProfileSuccess(e:ProfilerEvent):void 
		{
			trace("Profile creation success:");
			trace("Profiler id = " + e.profile.customerProfileID);
			trace("Payment ids = " + e.profile.paymentProfiles);
		}
		
	}

}