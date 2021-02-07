import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/products.dart';
import 'package:flutterEcommerceProject/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
   final String id;
  UserProductItem(this.title, this.imageUrl, this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListTile(
        title: Text(this.title),
        leading: CircleAvatar(backgroundImage: NetworkImage(this.imageUrl),),
        trailing: Container(
          width: 100,
          child: Row(children: [
            IconButton(icon: Icon(Icons.edit),onPressed: (){Navigator.pushNamed(context, EditProductScreen.routeName,arguments: id);},color: Theme.of(context).primaryColor,),
            IconButton(icon: Icon(Icons.delete),onPressed: (){
              Provider.of<Products>(context,listen: false).deleteItem(id);
            },color: Theme.of(context).errorColor,)
          ],),
        ),
      ),
      
    );
  }
}