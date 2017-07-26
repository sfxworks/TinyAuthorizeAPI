package net.sfxworks.tinyauthorizeapi.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class ChargeEvent extends Event 
	{
		public static const CHARGE_SUCCESS:String = "chargeSuccess";
		public static const CHARGE_DECLINED:String = "chargeFail";
		public static const CHARGE_ERROR:String = "chargeError";
		public static const CHARGE_REVIEW:String = "chargeHeldForReview";
		
		private var _refID:String;
		private var _transID:String;
		
		public function ChargeEvent(type:String, refID:String, transID:String=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_refID = refID;
			_transID = transID;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ChargeEvent(type, _refID, _transID, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ChargeEvent", "type", "refID", "transID", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get refID():String 
		{
			return _refID;
		}
		
		public function get transID():String 
		{
			return _transID;
		}
		
		
		
	}
	
}