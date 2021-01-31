import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final  _priceFocusNode = FocusNode() ;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar:AppBar(title:Text('Eidt Product')),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: SingleChildScrollView(
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title',),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                  ),
                  TextFormField(  
                    decoration: InputDecoration(labelText: 'Price',),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                  ),
                ],),
              )
            
            ),
          ),
      ),
      
    );
  }
}

