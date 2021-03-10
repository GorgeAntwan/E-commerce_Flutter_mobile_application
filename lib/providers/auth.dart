import 'package:flutter/widgets.dart';
import 'package:flutterEcommerceProject/models/http_exeption.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
   
   String _token;
   DateTime _expiryDate;
   String _userId;
   bool get isAuth{
     return token != null;
   }
   String get token {
     if(_token !=null &&_expiryDate!=null &&_expiryDate.isAfter(DateTime.now())){
       return _token;
     }
     return null;
   }
   String get userId{
     return _userId;
   }
   Future<void> authinticate(String email,String password,String urlSegment) async{
       var params = {
       'key':'AIzaSyCCrtQ042NyWpQZpiy15X_N6PFHeujt_7A'
     };
     //https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
     var url = Uri.https('identitytoolkit.googleapis.com','v1/accounts:$urlSegment',params);
     try { 

      final response = await http.post(url,body:json.encode({
       'email' :email,
       'password':password,
       'returnSecureToken' :true,
      }));
      final responseData = json.decode(response.body);
       print('responseData : $responseData');
       if(responseData['error'] != null){
          
          throw HttpExeption(responseData['error']['message']);
       }
       _token = responseData['idToken'];
       _userId = responseData['localId'];
       _expiryDate =DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn']) )) ;
       print(_expiryDate);
       notifyListeners();
     } catch (error) {
        throw error;
     }
   }
   Future<void> signup (String email,String password) async {
     
     return authinticate( email, password, 'signUp');
   }

   Future<void> login(String email,String password)async{
        return authinticate( email, password, 'signInWithPassword');
   }

}