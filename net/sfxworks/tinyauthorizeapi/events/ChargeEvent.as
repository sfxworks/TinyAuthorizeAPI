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
		
		public function ChargeEvent(type:String, refID:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_refID = refID;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ChargeEvent(type, _refID, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ChargeEvent", "type", "refID", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get returnData():Object 
		{
			return _returnData;
		}
		
		
	}
	
}