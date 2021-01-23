import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/screens/product_details_screen.dart';
class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductItem(this.id, this.title,this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridTile(child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,arguments: id);
          },
          child: Image.network(this.imageUrl,
           fit:BoxFit.cover,
          ),
        ),
      ),
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTileBar(
           backgroundColor: Colors.black87,
           title: Text(this.title,textAlign: TextAlign.center),
           leading: IconButton(icon: Icon(Icons.favorite,
            color: Theme.of(context).accentColor,
           ),onPressed: (){},),
           trailing: IconButton(icon: Icon(Icons.shopping_cart,
             color: Theme.of(context).accentColor,
           ),onPressed: (){}),
           
          ),
        ) ,
      ),
    );
  }
}