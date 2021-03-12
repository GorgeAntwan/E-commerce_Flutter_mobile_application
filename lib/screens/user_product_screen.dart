import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/products.dart';
import 'package:flutterEcommerceProject/widgets/app_drawer.dart';
import 'package:flutterEcommerceProject/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import 'edit_product_screen.dart';
class UserProductScreen extends StatelessWidget {
   static const routeName = '/user-products';
   Future<void> _refreshProducts(BuildContext context)async{
      await Provider.of<Products>(context,listen: false).fetchAndSetProduct(true);
   }
  @override
  Widget build(BuildContext context) {
    print('builder..');
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title:const Text('Your Product'),
          actions: [
             IconButton(onPressed: (){
               Navigator.pushNamed(context, EditProductScreen.routeName);
             }, icon: const Icon(Icons.add),)
          ],
         
        ),
        drawer:  AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<Products>(context,listen: false).fetchAndSetProduct(true),      
            builder: (context ,snapshot )=>
             snapshot.connectionState == ConnectionState.waiting ?
             Center(child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              
                child: Container(width:100,height: 100,color:Colors.grey[200],child: Center(child: CircularProgressIndicator(strokeWidth: 3,)))),)
          
              :
             RefreshIndicator(
            
            onRefresh: ()=> _refreshProducts(context) ,
            child: Consumer<Products>(
                   builder: (ctx,productData,_)=>
                           Padding(
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
          ),
        ),
      ),
    );
  }
}