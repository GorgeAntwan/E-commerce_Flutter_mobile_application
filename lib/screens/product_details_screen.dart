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
      ),),
    );
  }
}