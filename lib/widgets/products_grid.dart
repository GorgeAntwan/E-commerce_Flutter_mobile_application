import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/products.dart';
import 'package:flutterEcommerceProject/widgets/product_item.dart';
import 'package:provider/provider.dart';
class ProductsGrid extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final product = productData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      ),
      itemCount: product.length,
      itemBuilder: (context,i)=> ProductItem(
        product[i].id,
        product[i].title,
        product[i].imageUrl,
      ),
      
    );
  }
}