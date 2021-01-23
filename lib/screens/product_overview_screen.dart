import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/widgets/products_grid.dart';
class ProductOverviewScreen extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child:ProductsGrid(),
        ),
      ),
    );
  }
}
