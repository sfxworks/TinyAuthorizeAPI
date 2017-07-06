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
		private var _items:Vector.<String>;
		
		/**@info
		 * An array of item prices to corrospond with an item name.
		 */
		private var _prices:Vector.<int>;
		
		//If values are changed a new total is created.
		private var _subTotal:Number
		private var _tax:Number;
		private var _discount:Number;
		private var _total:Number;
		
		
		private var _cartItemRef:Vector.<int>;
		private var _quantities:Vector.<int>;
		
		public function Cart() 
		{
			_subTotal = 0;
			_tax = 0;
			_discount = 0;
			_total = 0;
			
			_items = new Vector.<String>();
			_prices = new Vector.<int>();
		}
		
		public function addOrUpdate(itemName:String, price:int):void
		{
			if (items.indexOf(itemName) == -1)
			{
				items.push(itemName);
				_prices.push(price);
			}
			else
			{
				_prices[items.indexOf(itemName)] = price;
			}
		}
		
		public function removeItem(itemName:String):void
		{
			var indexToRemove:int = items.indexOf(itemName);
			_items = _items.splice(indexToRemove, 1);
			_prices = _prices.splice(indexToRemove, 1);
		}
		
		public function addToCart(itemRef:int, quantity:int, overwriteQuantity:Boolean=false):void
		{
			if (_cartItemRef.indexOf(itemRef) == -1)
			{
				_cartItemRef.push(itemRef);
				_quantities.push(quantity);
			}
			else
			{
				if (overwriteQuantity)
				{
					_quantities[_cartItemRef.indexOf(itemRef)] = quantity;
				}
				else
				{
					_quantities[_cartItemRef.indexOf(itemRef)] += quantity;
				}
			}
			
			generateTotals();
		}
		
		//I was going to include parts of these in their respective getters, but it's cool here for now.
		private function generateTotals():void
		{
			_subTotal = 0;
			for each(var itemRef:int in _cartItemRef)
			{
				_subTotal += (_prices[itemRef] * _quantities[itemRef]);
			}
			_tax = _subTotal + (_subTotal * _tax) - (_subTotal * _discount);
		}
		
		public function removeFromCard(itemRef:int):void
		{
			_cartItemRef = _cartItemRef.splice(itemRef, 1);
			_quantities = _quantities.splice(itemRef, 1);
			generateTotals();
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
		
		public function get items():Vector.<String> 
		{
			return _items;
		}
		
		public function get prices():Vector.<int> 
		{
			return _prices;
		}
		
		
		
		
		
	}

}