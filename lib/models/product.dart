import 'package:flutter/foundation.dart';
class Product {
  final String id;
  final String name;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({

     @required this.id,
     @required this.name,
     @required this.title,
     @required this.description,
     @required this.price,
     @required this.imageUrl,
      this.isFavorite
  });
}
