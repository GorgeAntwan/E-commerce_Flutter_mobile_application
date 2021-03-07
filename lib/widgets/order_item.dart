import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/order.dart' as ord;
import 'package:intl/intl.dart';
class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpanded =false;
  @override
  Widget build(BuildContext context) {
    
    var listView = ListView(
               
             children: 
                      
               widget.order.products.map(
                  (prod)=>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween
                    ,children: [
                    Text(prod.title,
                    style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold),),
                    Text('${prod.quantity} x \$${prod.price}', style: TextStyle(fontSize: 12,
                    color:Colors.grey))
                  ],)
                
               ).toList()
            );
    return Container(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(DateFormat('dd/mm/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(icon: isExpanded? Icon(Icons.expand_more):Icon(Icons.expand_less),onPressed: (){
              setState(() {
                
                this.isExpanded =!isExpanded;
              });
            },),
          ),
          if(isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical:4),
               height: min(widget.order.products.length*20.0+10, 100),
              child:listView)
          
        ],
      ), ),
    );
  }
}