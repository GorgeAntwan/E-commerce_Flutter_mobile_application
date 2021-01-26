import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/cart.dart' show Cart;
import 'package:flutterEcommerceProject/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ignore: deprecated_member_use
                    Text(
                      'Total Price',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                        backgroundColor:Theme.of(context).primaryColor ,
                        labelStyle: TextStyle(
                          
                          backgroundColor: Theme.of(context).primaryColor,
                          
                        ),
                        label: Text(
                          // ignore: deprecated_member_use
                          '\$${cart.totalAmount}',style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color,),
                        )),
                        FlatButton(onPressed: (){}, child: Text('ORDER NOW',style: TextStyle(color:Theme.of(context).primaryColor)))
                  ],
                ),
              ),
            ),
           SizedBox(height: 10,),
             Expanded(
               child: ListView.builder(itemCount: cart.countItems,
               itemBuilder: (context,i)=>
                CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].price
                )

            ),
             )
          ],
        ),
      ),
    ));
  }
}
