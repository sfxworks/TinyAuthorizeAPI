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
		
		public function chargeCard(card:Card, total:Number, refId:String=null):void
		{
			var sendingObj:XML =  <createCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" />
			sendingObj.createTransactionRequest.merchantAuthentication.name = log;
			sendingObj.createTransactionRequest.merchantAuthentication.transactionKey = tK;
			
			sendingObj.createTransactionRequest.refId = refId;
			sendingObj.createTransactionRequest.transactionType = "authCaptureTransaction";
			sendingObj.createTransactionRequest.amount = total.toString();
			sendingObj.createTransactionRequest.payment.creditCard.cardNumber = card.number;
			sendingObj.createTransactionRequest.payment.creditCard.expirationDate = card.expiration;
			sendingObj.createTransactionRequest.payment.creditCard.cardCode = card.ccv;
			
			var rq:URLRequest = new URLRequest(endpoint);
			rq.method = URLRequestMethod.POST;
			rq.requestHeaders.push(new URLRequestHeader("Content-Type", "application/json"));
			rq.data =  '<?xml version="1.0" encoding="utf-8"?>\n' + sendingObj.toXMLString();
			
			var urll:URLLoader = new URLLoader();
			urll.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			urll.addEventListener(Event.COMPLETE, handleCardChargeComplete);
			urll.load(rq);
		}
		
		private function handleIOError(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function handleCardChargeComplete(e:Event):void 
		{
			var refID:String = "";
			if (e.target.data.refId != null)
				refID = e.target.data.refId;
			
			switch(parseInt(e.target.data.transactionResponse.responseCode))
			{
				case 1:
					dispatchEvent(new ChargeEvent(ChargeEvent.CHARGE_SUCCESS, refID));
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
		
		public function chargeProfile(profile:CustomerProfile, total:Number, paymentProfile:int=0, ref:String=null):void
		{
			var sendingObj:Object = new Object();
			sendingObj.createTransactionRequest.merchantAuthentication.name = log;
			sendingObj.createTransactionRequest.merchantAuthentication.transactionKey = tK;
			
			sendingObj.createTransactionRequest.refId = ref;
			sendingObj.createTransactionRequest.transactionRequest.transactionType = "authCaptureTransaction";
			
			sendingObj.createTransactionRequest.transactionRequest.amount = total;
			sendingObj.createTransactionRequest.transactionRequest.profile.customerProfileId = profile.customerProfileID;
			sendingObj.createTransactionRequest.transactionRequest.profile.paymentProfile.paymentProfileId = profile.paymentProfiles[paymentProfile].paymentProfileID;
			
			var rq:URLRequest = new URLRequest(endpoint);
			rq.method = URLRequestMethod.POST;
			rq.requestHeaders.push(new URLRequestHeader("Content-Type", "application/json"));
			var urll:URLLoader = new URLLoader();
			urll.data = JSON.stringify(sendingObj);
			urll.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			urll.addEventListener(Event.COMPLETE, handleCardChargeComplete);
			urll.load(rq);
		}
		
	}

}