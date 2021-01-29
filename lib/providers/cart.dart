import 'package:flutter/foundation.dart';

class CartItems {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItems(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItems> _items ={};

  Map<String, CartItems> get items {
    return {..._items};
  }
  int get countItems{
    return _items.length;
  }
  double get totalAmount{
    var total=0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
     });
    return total;
  }
  void removeItem(String productId){
         _items.remove(productId);
         notifyListeners();
  }
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //if the item is already in the cart update the item in the cart

      _items.update(
          productId,
          (exsistProduct) => CartItems(
              id: exsistProduct.id,
              title: exsistProduct.title,
              quantity: exsistProduct.quantity + 1,
              price: exsistProduct.price));
    } else {
      // if the item is not in the cart and add new item to the cart

      _items.putIfAbsent(
          productId,
          () => CartItems(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }
  void removeSingelItem(productId){
    if(!_items.containsKey(productId)){
          return;
    }if(_items[productId].quantity > 1){
             _items.update(productId, (existingCartItem)
              => CartItems(id: existingCartItem.id, title: existingCartItem.title, quantity: existingCartItem.quantity-1, price: existingCartItem.price));
    }else{
           _items.remove(productId);

    }
    notifyListeners();
  }
  void clearItem(){
     _items= {};
     notifyListeners();
   }
}
