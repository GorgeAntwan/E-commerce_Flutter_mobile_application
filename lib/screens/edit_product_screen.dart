import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterEcommerceProject/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final  _priceFocusNode = FocusNode() ;
  final _descriptionFocusNode = FocusNode() ;
  final _imageUrlController = TextEditingController();
 final _imageUrlFocusNode = FocusNode() ;
 final _form = GlobalKey<FormState>();
 Product edite_product= Product(id:null,title: '',description: '',price:0.0,imageUrl:'',isFavorite: false);
 @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();

    super.dispose();
  }
  void _updateImageUrl(){
      if(!_imageUrlFocusNode.hasFocus){
        setState(() {
          
        });
      }
  }
 void _saveForm (){
  
       final isValid = _form.currentState.validate();
       if(!isValid){
         return;
       }
      print(edite_product.title);
      print(edite_product.description);
      print(edite_product.price);
      print(edite_product.imageUrl);
     

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar:AppBar(
            title:Text('Eidt Product'),
            actions: [
              IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
            ],
          ),
          
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title',),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please Provide Title.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(  
                    decoration: InputDecoration(labelText: 'Price',),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                     onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value){
                      edite_product= Product(
                        id:null,
                        title: edite_product.title,
                        description:edite_product.description,
                        price:double.parse(value),
                        imageUrl:edite_product.imageUrl,
                        isFavorite: edite_product.isFavorite
                      );
                    },
                  ),
                   TextFormField(  
                    decoration: InputDecoration(labelText: 'Description',),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                     onSaved: (value){
                      edite_product= Product(
                        id:null,
                        title: edite_product.title,
                        description:value,
                        price:edite_product.price,
                        imageUrl:edite_product.imageUrl,
                        isFavorite: edite_product.isFavorite
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 100,
                        width:100,
                        margin: EdgeInsets.only(top:8,right:10),
                        decoration: BoxDecoration(
                          border:Border.all(width: 1,color:Colors.grey),

                        ),
                        child: _imageUrlController.text.isEmpty ?Text('Enter a Url'):FittedBox(
                          child:Image.network(_imageUrlController.text,fit: BoxFit.cover,),
                        ),
                      ),
                      Expanded(
                              child: TextFormField(
                              decoration: InputDecoration(labelText: 'Image Url'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (_){
                                _saveForm();
                              },
                               onSaved: (value){
                              edite_product= Product(
                                id:null,
                                title: edite_product.title,
                                description:edite_product.description,
                                price:edite_product.price,
                                imageUrl:value,
                                isFavorite: edite_product.isFavorite
                              );
                            },
                        ),
                      ),
                    ],
                  )
                ],),
              )
            
            ),
          ),
      ),
      
    );
  }
}

