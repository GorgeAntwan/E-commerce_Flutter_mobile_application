import 'package:flutter/cupertino.dart';
import 'package:flutterEcommerceProject/providers/cart.dart' ;
import 'dart:convert';
import 'package:http/http.dart' as http;
 
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
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }
  
  Future<void> fetchAndSetOrders()async{
    try {
     
       var url = Uri.https(
          'flutter-e-commerce-cb3f8-default-rtdb.firebaseio.com',
          'orders.json');
       final response = await http.get(url);
       final extractedData = json.decode(response.body) as Map<String,dynamic>;
       List<OrderItem> loadedOrder =[];
       if(extractedData ==null){
         return;
       }
         
       extractedData.forEach((orderId, orderData)=>{
          loadedOrder.add(OrderItem(
            id: orderId, 
            amount: orderData['amount'], 
            dateTime: DateTime.parse(orderData['dateTime']),
             products: (orderData['products'] as List<dynamic>)
             .map((item) => CartItems(
                id: item['id'], 
                price: item['price'],
                quantity: item['quantity'], 
                title: item['title']

             )).toList(),
            
          ))
       });
       _orders = loadedOrder.reversed.toList(); //.reversed.toList() to sort list to new order in top
      
       notifyListeners();
      
    } catch (e) {
        print('Error :$e');
    }
  }
  Future<void> addOrder(List<CartItems> cartProducts, double total) async {
   
    try {
      final timeStamp = DateTime.now();

      var url = Uri.https(
          'flutter-e-commerce-cb3f8-default-rtdb.firebaseio.com',
          'orders.json');
       
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'price': cp.price,
                      'quantity': cp.quantity,
                    })
                .toList()
          }));
          
       _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timeStamp,
            products: cartProducts));
       notifyListeners();
    } catch (e) {}

   
  }
}
