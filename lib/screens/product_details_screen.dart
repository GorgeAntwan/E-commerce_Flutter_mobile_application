import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/product.dart';
import 'package:flutterEcommerceProject/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {

    static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    Product product = Provider.of<Products>(context,listen: false).findById(productId);
    return Container(
      child: Scaffold(appBar: AppBar(
        title: Text(product.title)
      ),
       body: SingleChildScrollView(
         child:Column(
           children: [
                Container(child:Image.network(product.imageUrl,fit: BoxFit.cover,width: double.infinity,height: 300,),),
                Container(padding: EdgeInsets.all(10),child:Text('\$${product.price}',style: TextStyle(fontSize: 20,color: Colors.grey),))  ,
                Container(padding: EdgeInsets.all(10),child:Text('${product.title}',style: TextStyle(fontSize: 18,))  ),

           ],
         )
       ),
      ),
    );
  }
}