import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterEcommerceProject/providers/product.dart';
import 'package:flutterEcommerceProject/providers/products.dart';
import 'package:provider/provider.dart';

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
 var _isInit = true;
 var _intialValues = {
   'id':'',
   'title': '',
   'description': '',
   'price':'',
   'imageUrl':'',
 };
 var _isLoading = false;
 @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }
  @override
  void didChangeDependencies() {
      if(_isInit){
       final productId =  ModalRoute.of(context).settings.arguments as String;
       if(productId!=null){
          edite_product = Provider.of<Products>(context).findById(productId);
          _intialValues = {
              'title': edite_product.title,
              'description':edite_product.description,
              'price':edite_product.price.toString(),
              //'imageUrl':edite_product.imageUrl,
              'imageUrl' :''
            };
          _imageUrlController.text = edite_product.imageUrl;
       }
      }
   
    super.didChangeDependencies();
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
      if(_imageUrlController.text.isEmpty ){
       
         return ;
      }
      if(!_imageUrlController.text.startsWith('http')&&!_imageUrlController.text.startsWith('https')){
           
           return ;
      }
      if(!_imageUrlController.text.endsWith('.jpg')&&!_imageUrlController.text.endsWith('.jpeg')&&!_imageUrlController.text.endsWith('.png')){
        return ;
      }
      if(!_imageUrlFocusNode.hasFocus){
        setState(() {
          
        });
      }
  }
 Future<void> _saveForm () async{
  
       final isValid = _form.currentState.validate();
       if(!isValid){
         return;
       }
       _form.currentState.save();
       setState(() {
         _isLoading =true;
       });
      if(edite_product.id!=null){
       print(edite_product.id);
         print(edite_product.title);
          print(edite_product.description);
            await Provider.of<Products>(context,listen: false).updateItem(edite_product.id,edite_product);
             setState(() {
                _isLoading =false;
             });
             Navigator.of(context).pop();
      }else{  
         
        

        try {
           await Provider.of<Products>(context,listen: false).addItem(edite_product);
          
           Navigator.of(context).pop();
             
        } catch (error) {
            print("error:$error");
           await  showDialog(context: context,
            builder: (cntx)=>AlertDialog(
              title: Text('An error occurred !'),
              content: Text('SomeThing went wrong.'),
              actions: [
                TextButton(onPressed: (){
                      Navigator.of(context).pop();  
                }, child: Text('Okay'))
              ],
            )
            );
        }finally{
           setState(() {
                _isLoading =false;
            });
        }

      }
     
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
          
          body: _isLoading? Center(child:CircularProgressIndicator()): Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(children: [
                  TextFormField(
                    initialValue: _intialValues['title'],
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
                      onSaved: (value){
                              edite_product= Product(
                                  id:edite_product.id,
                                title: value,
                                description:edite_product.description,
                                price:edite_product.price,
                                imageUrl:value,
                                isFavorite: edite_product.isFavorite
                              );
                            },
                    
                  ),
                  TextFormField(  
                    initialValue: _intialValues['price'],
                    decoration: InputDecoration(labelText: 'Price',),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                     onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value){
                      edite_product= Product(
                        id:edite_product.id,
                        title: edite_product.title,
                        description:edite_product.description,
                        price:double.parse(value),
                        imageUrl:edite_product.imageUrl,
                        isFavorite: edite_product.isFavorite
                      );
                    },
                    validator:(value){
                      if(value.isEmpty){
                        return 'Please Enter Price.';
                      }else if(double.tryParse(value)==null){
                               return "Enter Valid Prcie.";
                      }else if (double.parse(value)<=0){
                        return 'price must br greater than Zero';
                      }
                      return null;
                    }
                  ),
                   TextFormField(  
                    initialValue: _intialValues['description'],
                    decoration: InputDecoration(labelText: 'Description',),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                     onSaved: (value){
                      edite_product= Product(
                        id:edite_product.id,
                        title: edite_product.title,
                        description:value,
                        price:edite_product.price,
                        imageUrl:edite_product.imageUrl,
                        isFavorite: edite_product.isFavorite
                      );
                    },
                     validator:(value){
                      if(value.isEmpty){
                        return 'Please Enter Description.';
                      }else if(value.length<=10){
                               return "Description Must be greater than 10 characters.";
                      } 
                      return null;
                    }
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
                                  id:edite_product.id,
                                title: edite_product.title,
                                description:edite_product.description,
                                price:edite_product.price,
                                imageUrl:value,
                                isFavorite: edite_product.isFavorite
                              );
                            },
                             validator:(value){
                              if(value.isEmpty){
                                return 'Please Enter Url.';
                              }else if(!value.startsWith('http')&&!value.startsWith('https')){
                                      return "Please Enter Valid Url.";
                              }else if (!value.endsWith('.png')&&!value.endsWith('.jpg')&&!value.endsWith('.jpeg')){
                               return "Please Enter Valid Url.";
                              }
                              return null;
                            }
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

