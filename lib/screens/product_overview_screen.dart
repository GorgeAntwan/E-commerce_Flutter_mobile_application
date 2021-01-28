import 'package:flutter/material.dart';
import 'package:flutterEcommerceProject/providers/cart.dart';
import 'package:flutterEcommerceProject/screens/cart_screen.dart';
import 'package:flutterEcommerceProject/widgets/app_drawer.dart';
import 'package:flutterEcommerceProject/widgets/badge.dart';
import 'package:flutterEcommerceProject/widgets/products_grid.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

bool isFavorited = false;
enum FilterOption { Favorited, All }

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
   
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
          actions: [
            PopupMenuButton(
                onSelected: (FilterOption selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOption.Favorited) {
                      isFavorited = true;
                    } else {
                      isFavorited = false;
                    }
                  });
                },
                itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('Only Favorite '),
                        value: FilterOption.Favorited,
                      ),
                      PopupMenuItem(
                        child: Text('Show All '),
                        value: FilterOption.All,
                      ),
                    ]),
            Consumer<Cart>(
              builder: (cntx, cart, _) => Badge(
                  child: IconButton(

                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context,CartScreen.routeName);
                    },
                  ),
                  value: cart.countItems.toString()),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ProductsGrid(isFavorited),
        ),
      ),
    );
  }
}
