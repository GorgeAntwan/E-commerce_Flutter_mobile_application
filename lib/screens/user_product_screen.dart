import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/products.dart';
import 'package:flutterEcommerceProject/widgets/app_drawer.dart';
import 'package:flutterEcommerceProject/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import 'edit_product_screen.dart';
class UserProductScreen extends StatelessWidget {
   static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title:const Text('Your Product'),
          actions: [
             IconButton(onPressed: (){
               Navigator.pushReplacementNamed(context, EditProductScreen.routeName);
             }, icon: const Icon(Icons.add),)
          ],
         
        ),
        drawer:  AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (_,i)=>Column(
              children: [
                UserProductItem(productData.items[i].title,productData.items[i].imageUrl,productData.items[i].id),
                Divider(),
              ],
            )
                
            ),
        ),
      ),
    );
  }
}