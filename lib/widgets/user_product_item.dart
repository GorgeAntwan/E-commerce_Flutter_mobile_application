import 'package:flutter/material.dart';
class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  UserProductItem(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListTile(
        title: Text(this.title),
        leading: CircleAvatar(backgroundImage: NetworkImage(this.imageUrl),),
        trailing: Container(
          width: 100,
          child: Row(children: [
            IconButton(icon: Icon(Icons.edit),onPressed: (){},color: Theme.of(context).primaryColor,),
            IconButton(icon: Icon(Icons.delete),onPressed: (){},color: Theme.of(context).errorColor,)
          ],),
        ),
      ),
      
    );
  }
}