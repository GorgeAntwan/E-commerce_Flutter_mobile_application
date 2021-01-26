import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/cart.dart';
import 'package:flutterEcommerceProject/providers/product.dart';
import 'package:flutterEcommerceProject/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
class ProductItem extends StatelessWidget {
 /*
  *  final String id;
  final String title;
  final String imageUrl;

  const ProductItem(this.id, this.title,this.imageUrl);
  */
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Container(
      child: GridTile(child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,arguments: product.id);
          },
          child: Image.network(product.imageUrl,
           fit:BoxFit.cover,
          ),
        ),
      ),
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTileBar(
           backgroundColor: Colors.black87,
           title: Text(product.title,textAlign: TextAlign.center),
           leading: Consumer<Product>(
             builder: (cntx,product,_)=>
                IconButton(icon: Icon(product.isFavorite? Icons.favorite : Icons.favorite_border,
              color: Theme.of(context).accentColor,
             ),onPressed: (){
               product.toggleFavoriteStatus();
             },),
           ),
           trailing: Consumer<Cart>(builder: (cntx,cart,_)=>IconButton(icon: Icon(Icons.shopping_cart,
             color: Theme.of(context).accentColor,
           ),onPressed: (){
             cart.addItem(product.id, product.price, product.title);
           }),) 
           
          ),
        ) ,
      ),
    );
  }
}
   
