import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/cart.dart' show Cart;
import 'package:flutterEcommerceProject/providers/order.dart';
import 'package:flutterEcommerceProject/widgets/app_drawer.dart';
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
      drawer: AppDrawer(),
      body: Container(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: deprecated_member_use
                      Text(
                        'Total Price',
                        style: TextStyle(fontSize: 20),
                      ),
                      //Spacer(),
                      SizedBox(height: 20,),
                      Chip(
                          backgroundColor:Theme.of(context).primaryColor ,
                          labelStyle: TextStyle(
                            
                            backgroundColor: Theme.of(context).primaryColor,
                            
                          ),
                          label: Text(
                            // ignore: deprecated_member_use
                            '\$${cart.totalAmount.toStringAsFixed(2)}',style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color,),
                          )),
                          OrderButton(cart: cart)
                    ],
                  ),
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

class OrderButton extends StatefulWidget {
  
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;
  
  @override
  _OrderButtonState createState() => _OrderButtonState();
}
 
class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
   
    return TextButton(onPressed: (widget.cart.totalAmount<=0 || _isLoading ) ? 
      
      null: () async{

      setState(() {
        _isLoading = true;
      });

      await Provider.of<Orders>(context,listen: false).addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount);

      widget.cart.clearItem();

      setState(() {
        _isLoading = false;
      });

    }, child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW',style: TextStyle(color:Theme.of(context).primaryColor)));
  }
}
