import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/order.dart' show Orders;
import 'package:flutterEcommerceProject/widgets/app_drawer.dart';
import 'package:flutterEcommerceProject/widgets/order_item.dart';
import 'package:provider/provider.dart';
class OrderScreen extends StatelessWidget {
  static const routeName ='/orders';

  @override
  Widget build(BuildContext context) {
    
    print('building order');
    return Container(
      child: Scaffold(appBar: AppBar(
        title:Text('Your order'),
       ),
       drawer: AppDrawer(),
       body:  FutureBuilder(
         future:  Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
         builder:(cntx,dataSnapshot){
               if(dataSnapshot.connectionState == ConnectionState.waiting){
                   return Center(child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      
                        child: Container(width:100,height: 100,color:Colors.grey[200],child: Center(child: CircularProgressIndicator(strokeWidth: 3,)))),);
              
               }else{
                 if(dataSnapshot.error != null){
                   return Center(child:Text('An error occured!!'));
                 }else {
                       return Consumer<Orders>(

                            builder:(cntx,orderData,child) =>ListView.builder(
                            itemCount:orderData.orders.length,
                            itemBuilder: (cntx,i)=>OrderItem(orderData.orders[i])
                      ),
                       );
                 }
               }
       },)
      
      ),
    );
  }
}