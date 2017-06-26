package net.sfxworks.tinyauthorizeapi 
{
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class Card 
	{
		private var _number:String;
		private var _expiration:String;
		private var _ccv:String;
		private var _cardType:String;
		private var _paymentProfileID:String;
		
		public function Card(number:String, expriation:String, ccv:String, cardType:String = null, paymentProfileID:String) 
		{
			_number = number;
			_expiration = expiration;
			_ccv = ccv;
			_cardType = cardType;
			_paymentProfileID = paymentProfileID;
		}
		
		public function get number():String 
		{
			return _number;
		}
		
		public function get expiration():String 
		{
			return _expiration;
		}
		
		public function get ccv():String 
		{
			return _ccv;
		}
		
		public function get cardType():String 
		{
			return _cardType;
		}
		
		public function get paymentProfileID():String 
		{
			return _paymentProfileID;
		}
		
	}

}