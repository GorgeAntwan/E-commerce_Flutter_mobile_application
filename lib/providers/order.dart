import 'package:flutter/cupertino.dart';
import 'package:flutterEcommerceProject/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItems> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
   List<OrderItem> _orders =[];
   List<OrderItem> get orders {
      return [..._orders];
   }
   void addOrder(List<CartItems>products,double total ){
     print("products.length");
     print(products.length);
     print(total);
     _orders.insert(0,
     OrderItem(id:DateTime.now().toString(),amount:total,dateTime:DateTime.now(),products:products));
     notifyListeners();

   }



}
