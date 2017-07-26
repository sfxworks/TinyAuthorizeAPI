package net.sfxworks.tinyauthorizeapi 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import net.sfxworks.tinyauthorizeapi.definitions.Card;
	import net.sfxworks.tinyauthorizeapi.definitions.CustomerProfile;
	import net.sfxworks.tinyauthorizeapi.events.ChargeEvent;
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class Charger extends Communicator
	{
		
		
		public function Charger(login:String, transactKey:String, mode:String) 
		{
			super(login, transactKey, mode);
			
		}
		
		public function chargeCard(card:Card, total:Number, refId:String=null):Object
		{
			var sendingObj:XML =  <createTransactionRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" />
			sendingObj.merchantAuthentication.name = log;
			sendingObj.merchantAuthentication.transactionKey = tK;
			
			sendingObj.refId = refId;
			sendingObj.transactionRequest.transactionType = "authCaptureTransaction";
			sendingObj.transactionRequest.amount = total.toString();
			sendingObj.transactionRequest.payment.creditCard.cardNumber = card.number;
			sendingObj.transactionRequest.payment.creditCard.expirationDate = card.expiration;
			sendingObj.transactionRequest.payment.creditCard.cardCode = card.ccv;
			
			var rq:URLRequest = new URLRequest(endpoint);
			rq.method = URLRequestMethod.POST;
			rq.requestHeaders.push(new URLRequestHeader("Content-Type", "text/xml"));
			rq.data =  '<?xml version="1.0" encoding="utf-8"?>\n' + sendingObj.toXMLString();
			
			var urll:URLLoader = new URLLoader();
			urll.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			urll.addEventListener(Event.COMPLETE, handleCardChargeComplete);
			urll.load(rq);
			
			return rq.data;
		}
		
		private function handleIOError(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function handleCardChargeComplete(e:Event):void 
		{
			trace("Response = " + e.target.data);
			var returnData:XML = new XML(e.target.data);
			returnData = removeNamespace(returnData.toXMLString());
			
			
			var refID:String = "";
			if (returnData.refId != null)
				refID = returnData.refId;
			
			switch(parseInt(returnData.transactionResponse.responseCode))
			{
				case 1:
					dispatchEvent(new ChargeEvent(ChargeEvent.CHARGE_SUCCESS, refID, returnData.transactionResponse.transId));
					break;
				case 2:
					dispatchEvent(new ChargeEvent(ChargeEvent.CHARGE_DECLINED, refID));
					break;
				case 3:
					dispatchEvent(new ChargeEvent(ChargeEvent.CHARGE_ERROR, refID));
					break;
				case 4:
					dispatchEvent(new ChargeEvent(ChargeEvent.CHARGE_REVIEW, refID));
					break;
					
			}
			
		}
		
		public function chargeProfile(profile:CustomerProfile, total:Number, paymentProfile:int=0, ref:String=null):Object
		{
			var sendingObj:XML = <createTransactionRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd"/>

			
			sendingObj.merchantAuthentication.name = log;
			sendingObj.merchantAuthentication.transactionKey = tK;
			
			sendingObj.refId = ref;
			sendingObj.transactionRequest.transactionType = "authCaptureTransaction";
			
			sendingObj.transactionRequest.amount = total;
			sendingObj.transactionRequest.profile.customerProfileId = profile.customerProfileID;
			sendingObj.transactionRequest.profile.paymentProfile.paymentProfileId = profile.paymentProfiles[paymentProfile].paymentProfileID;
			
			var rq:URLRequest = new URLRequest(endpoint);
			rq.method = URLRequestMethod.POST;
			rq.requestHeaders.push(new URLRequestHeader("Content-Type", "text/xml"));
			rq.data =  '<?xml version="1.0" encoding="utf-8"?>\n' + sendingObj.toXMLString();
			trace("Rq data = \n" + rq.data);
			
			var urll:URLLoader = new URLLoader();
			urll.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			urll.addEventListener(Event.COMPLETE, handleCardChargeComplete);
			urll.load(rq);
			return rq.data;
		}
		
		private function removeNamespace(str:String):XML
		{
			var nsRegEx:RegExp = new RegExp(" xmlns(?:.*?)?=\".*?\"", "gim");
			
			var resultXML:XML = new XML(str.replace(nsRegEx, "")); 
			return resultXML;
		}
		
	}

}