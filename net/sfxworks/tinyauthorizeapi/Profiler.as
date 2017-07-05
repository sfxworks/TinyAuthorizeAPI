package net.sfxworks.tinyauthorizeapi 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import net.sfxworks.tinyauthorizeapi.definitions.Card;
	import net.sfxworks.tinyauthorizeapi.definitions.CustomerProfile;
	import net.sfxworks.tinyauthorizeapi.events.ProfilerEvent;
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
		
		public function createProfile(card:Card, customerType:String, description:String=null, merchantCustomerId:String=null, email:String=null):void
		{
			//Append tag.
			var sendingObj:XML = <createCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" />
			
			sendingObj.merchantAuthentication.name = log;
			sendingObj.merchantAuthentication.transactionKey = tK;
			if (merchantCustomerId == null && description == null && email  && null)
			{
				throw new Error("At least one profile element (description, merchantCustomerID, email) must be present");
				return;
			} 
			if (merchantCustomerId != null)
				sendingObj.profile.merchantCustomerId = merchantCustomerId;
			if (description != null)
				sendingObj.profile.description = description;
			if (email != null)
				sendingObj.profile.email = email;
			
			sendingObj.profile.paymentProfiles.customerType = customerType;
			sendingObj.profile.paymentProfiles.payment.creditCard.cardNumber = card.number;
			sendingObj.profile.paymentProfiles.payment.creditCard.expirationDate = card.expiration;
			
			sendingObj.validationMode = "none";
			
			var rq:URLRequest = new URLRequest(endpoint);
			rq.method = URLRequestMethod.POST;
			rq.requestHeaders.push(new URLRequestHeader("Content-Type", "text/xml"));
			rq.data = '<?xml version="1.0" encoding="utf-8"?>\n' + sendingObj.toXMLString();
			var urll:URLLoader = new URLLoader();
			
			urll.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			urll.addEventListener(Event.COMPLETE, handleCardChargeComplete);
			urll.load(rq);
		}
		
		
		private function handleCardChargeComplete(e:Event):void 
		{
			trace("Retundata = " + e.target.data);
			var returnData:XML = new XML(e.target.data);
			trace("returndata =  " + returnData);
			switch(returnData.messages.resultCode)
			{
				case "Ok":
					var cards:Vector.<Card> = new Vector.<Card>();
					var returnPaymentProfiles:Array = new Array(returnData.customerPaymentProfileIdList);
					for each (var paymentProfileId:String in returnPaymentProfiles)
					{
						cards.push(new Card("", "", "", "", paymentProfileId));
					}
					dispatchEvent(new ProfilerEvent(ProfilerEvent.SUCCESS, new CustomerProfile(returnData.customerProfileId, cards, "individual")));
					break;
				case "Error":
					trace(e.target.data);
					dispatchEvent(new ProfilerEvent(ProfilerEvent.ERROR));
					break;
			}
		}
		
		private function handleIOError(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
	}

}