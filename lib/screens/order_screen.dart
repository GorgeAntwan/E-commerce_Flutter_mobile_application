import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/order.dart' show Orders;
import 'package:flutterEcommerceProject/widgets/app_drawer.dart';
import 'package:flutterEcommerceProject/widgets/order_item.dart';
import 'package:provider/provider.dart';
class OrderScreen extends StatelessWidget {
  static const routeName ='/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
     
    return Container(
      child: Scaffold(appBar: AppBar(
        title:Text('Your order'),
       ),
       drawer: AppDrawer(),
       body: ListView.builder(itemCount:orderData.orders.length,
         itemBuilder: (cntx,i)=>OrderItem(orderData.orders[i])),
      ),
    );
  }
}