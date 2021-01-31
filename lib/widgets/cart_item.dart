import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/cart.dart';
import 'package:provider/provider.dart';
class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String productId;
  const CartItem(  this.id, this.productId,this.title, this.quantity, this.price) ;

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Dismissible(
         key: ValueKey(id),
         background:Container(color:Theme.of(context).errorColor,
         child:Icon(Icons.delete,size: 40,color:Colors.white,)
         ,alignment: Alignment.centerRight,
         padding: EdgeInsets.only(right: 20),
         margin: EdgeInsets.symmetric(horizontal: 15,vertical:4),
         ),
         direction: DismissDirection.endToStart,
         onDismissed: (direction){
           Provider.of<Cart>(context,listen: false).removeItem(productId);
         },
         confirmDismiss: (direction){
           return showDialog(context: context,
           builder: (cntx)=>AlertDialog(
             title: Text('Are You Sure?'),
             content: Text('Do You Want Remove Item From Cart? '),
             actions: [
                FlatButton(onPressed: (){
                  Navigator.of(cntx).pop(false);
                }, child: Text('No')),
                FlatButton(onPressed: (){
                    Navigator.of(cntx).pop(true);
                }, child: Text('Yes'))
             ],
           ));
         },
         child: Card(
           margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: ListTile(
              leading :  FittedBox(fit: BoxFit.contain,child: CircleAvatar(child: Text('\$$price',style: TextStyle(fontSize: 10),),)),
            
               title: Text(title),
               subtitle: Text('Total \$ ${(price * quantity)}'),
               trailing: Text('$quantity x'),
             ),
           )
         ),
       ),
    );
  }
}