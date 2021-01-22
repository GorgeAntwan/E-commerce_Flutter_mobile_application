import 'dart:html';

import 'package:flutter/material.dart';
class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductItem(this.id, this.title,this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridTile(child: Image.network(this.imageUrl,
       fit:BoxFit.cover,
      ),
        footer: GridTileBar(
         backgroundColor: Colors.black45,
         title: Text(this.title,textAlign: TextAlign.center),
         leading: IconButton(icon: Icon(Icons.favorite),onPressed: (){},),
         trailing: IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){}),
        ) ,
      ),
    );
  }
}