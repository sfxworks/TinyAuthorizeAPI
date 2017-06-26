package net.sfxworks.tinyauthorizeapi 
{
	/**
	 * ...
	 * @author Samuel Walker
	 */
	public class Cart 
	{
		
		/**@info
		 * An array of item names to corrospond with a price.
		 */
		public var items:Vector.<String>;
		
		/**@info
		 * An array of item prices to corrospond with an item name.
		 */
		public var prices:Vector.<int>;
		
		//If values are changed a new total is created.
		private var _subTotal:Number
		private var _tax:Number;
		private var _discount:Number;
		private var _total:Number;
		
		
		private var _cartItemRef:Vector.<int>;
		private var _quantities:Vector.<int>;
		
		public function Cart() 
		{
			
		}
		
		public function addToCart(itemRef:int):void
		{
			
		}
		
		public function removeFromCard(itemRef:int):void
		{
			
		}
		
		public function generateTotal():String
		{
			
		}
		
		public function get tax():Number 
		{
			return _tax;
		}
		
		public function set tax(value:Number):void 
		{
			_tax = value;
		}
		
		public function get discount():Number 
		{
			return _discount;
		}
		
		public function set discount(value:Number):void 
		{
			_discount = value;
		}
		
		public function get total():Number 
		{
			return _total;
		}
		
		public function get subTotal():Number 
		{
			return _subTotal;
		}
		
		public function get cartItemRef():Vector.<int> 
		{
			return _cartItemRef;
		}
		
		public function get quantities():Vector.<int> 
		{
			return _quantities;
		}
		
		
		
		
		
	}

}