package net.sfxworks.tinyauthorizeapi.definitions 
{
	import net.sfxworks.tinyauthorizeapi.definitions.Card;
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class CustomerProfile 
	{
		private var _customerProfileID:String;
		private var _paymentProfiles:Vector.<Card>;
		private var _customerType:String;
		private var _merchantCustomerID:String;
		private var _description:String;
		private var _email:String;
		
		public function CustomerProfile(customerProfileID:String, paymentProfiles:Vector.<Card>, customerType:String, merchantCustomerID:String=null, description:String=null, email:String=null) 
		{
			_customerProfileID = customerProfileID;
			_paymentProfiles = paymentProfiles;
			_merchantCustomerID = merchantCustomerID;
			_description = description;
			_email = email;
			
		}
		
		public function get customerProfileID():String 
		{
			return _customerProfileID;
		}
		
		public function get paymentProfiles():Vector.<Card> 
		{
			return _paymentProfiles;
		}
		
		public function get customerType():String 
		{
			return _customerType;
		}
		
		public function get merchantCustomerID():String 
		{
			return _merchantCustomerID;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
		public function get email():String 
		{
			return _email;
		}
		
	}

}