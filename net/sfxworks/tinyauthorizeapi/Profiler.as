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
			if (merchantCustomerId == null && description == null && email == null)
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
			urll.addEventListener(Event.COMPLETE, handleProfileCreated);
			urll.load(rq);
		}
		
		
		private function handleProfileCreated(e:Event):void 
		{
			
			var returnData:XML = new XML(e.target.data); // removeNamespace(new String(e.target.data));
			returnData = removeNamespace(returnData.toXMLString()); //I have no time for gam- I mean namespaces.
			trace("returndata =  \n" + returnData);
			trace("Result message = " + returnData.messages.resultCode);
			switch(new String(returnData.messages.resultCode))
			{
				case "Ok":
					trace("Ok dispatched.");
					var cards:Vector.<Card> = new Vector.<Card>();
					var returnPaymentProfiles:Array = new Array(returnData.customerPaymentProfileIdList);
					for each (var paymentProfileId:String in returnPaymentProfiles)
					{
						cards.push(new Card("", "", "", "", paymentProfileId));
					}
					dispatchEvent(new ProfilerEvent(ProfilerEvent.SUCCESS, new CustomerProfile(returnData.customerProfileId, cards, "individual")));
					break;
				case "Error":
					trace("Error dispatched.");
					dispatchEvent(new ProfilerEvent(ProfilerEvent.ERROR));
					break;
			}
		}
		
		public function getCustomerProfile(merchID:String=null,customerProfileID:String=null, email:String=null ):void
		{
			if (merchID == null && customerProfileID == null && email == null)
			{
				throw new Error("At least one reference definition (merchID, customerProfileID, email) must be present.");
				return;
			}
			
			var sendingObj:XML = <getCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" />
			
			sendingObj.merchantAuthentication.name = log;
			sendingObj.merchantAuthentication.transactionKey = tK;
			if (merchID != null)
				sendingObj.merchantCustomerId = merchID;
			if (customerProfileID != null)
				sendingObj.customerProfileId = customerProfileID;
			if (email != null)
				sendingObj.email = email;
			
			var rq:URLRequest = new URLRequest(endpoint);
			rq.method = URLRequestMethod.POST;
			rq.requestHeaders.push(new URLRequestHeader("Content-Type", "text/xml"));
			rq.data = '<?xml version="1.0" encoding="utf-8"?>\n' + sendingObj.toXMLString();
			var urll:URLLoader = new URLLoader();
			
			urll.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			urll.addEventListener(Event.COMPLETE, handleProfileRetrieved);
			urll.load(rq);
			
		}
		
		private function handleProfileRetrieved(e:Event):void 
		{
			var returnedXML:XML = new XML(e.target.data);
			returnedXML = removeNamespace(returnedXML.toXMLString());
			trace("Result code = " + returnedXML.messages.resultCode);
			switch(new String(returnedXML.messages.resultCode))
			{
				case "Ok":
					var paymentProfiles:Vector.<Card> = new Vector.<Card>();
					
					for each (var paymentProfile:XML in returnedXML.profile.paymentProfiles)
					{
						trace("Payment profile = " + paymentProfile);
						//CREDIT CARD ONLY SUPPORTED AT THIS TIME.
						var card:Card = new Card(paymentProfile.payment.creditCard.cardNumber, paymentProfile.payment.creditCard.expiration, "", paymentProfile.payment.creditCard.cardType, paymentProfile.customerPaymentProfileId );
						paymentProfiles.push(card);
					}
					
					var customerProfile:CustomerProfile = new CustomerProfile(returnedXML.profile.customerProfileId, paymentProfiles, returnedXML.profile.customerType, returnedXML.profile.merchantCustomerId);
					dispatchEvent(new ProfilerEvent(ProfilerEvent.SUCCESS, customerProfile));
					
					trace("do stuff.");
					break;
				case "Error":
					trace("Error.");
					dispatchEvent(new ProfilerEvent(ProfilerEvent.ERROR));
					break;
			}
		}
		
		private function removeNamespace(str:String):XML
		{
			var nsRegEx:RegExp = new RegExp(" xmlns(?:.*?)?=\".*?\"", "gim");
			
			var resultXML:XML = new XML(str.replace(nsRegEx, "")); 
			return resultXML;
		}
		
		private function handleIOError(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
	}

}