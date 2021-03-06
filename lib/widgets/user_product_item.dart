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
    final scaffold = ScaffoldMessenger.of(context);
    return Container(
      child:ListTile(
        title: Text(this.title),
        leading: CircleAvatar(backgroundImage: NetworkImage(this.imageUrl),),
        trailing: Container(
          width: 100,
          child: Row(children: [
            IconButton(icon: Icon(Icons.edit),onPressed: (){Navigator.pushNamed(context, EditProductScreen.routeName,arguments: id);},color: Theme.of(context).primaryColor,),
            IconButton(icon: Icon(Icons.delete),onPressed: ()async {
              try {
                 await Provider.of<Products>(context,listen: false).deleteItem(id);
              } catch (error) {
                 scaffold.showSnackBar(SnackBar(content: Text('Deleting Failed.',style: TextStyle(color: Colors.red),textAlign: TextAlign.center,)));
              }
             
            },color: Theme.of(context).errorColor,)
          ],),
        ),
      ),
      
    );
  }
}