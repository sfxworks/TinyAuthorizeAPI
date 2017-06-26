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
		public static const CHARGE_FAIL:String = "chargeFail";
		
		private var _returnData:Object;
		
		public function ChargeEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_returnData = data;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ChargeEvent(type, _returnData, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ChargeEvent", "type", "returnData", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get returnData():Object 
		{
			return _returnData;
		}
		
		
	}
	
}