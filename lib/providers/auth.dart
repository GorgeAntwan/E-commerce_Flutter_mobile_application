import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutterEcommerceProject/models/http_exeption.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
   
   String _token;
   DateTime _expiryDate;
   String _userId;
   Timer _authTimer;
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
       _autoLogout();
       notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'userId': _userId,
        'token': _token,
        'expiryDate': _expiryDate.toIso8601String(),
        
      });
      prefs.setString('userData', userData);
     } catch (error) {
        throw error;
     }
   }
   // ignore: missing_return
   Future<bool> tryAutoLogin()async{
      final prefs = await SharedPreferences.getInstance();
      if(!prefs.containsKey('userData')){
          return false;
      }
      final extractedData = json.decode(prefs.getString('userData')) as Map<String,Object>; // why use Object becauose i have different data type string and Date
      print('extractedData userData :$extractedData');
      final expiryDate = DateTime.parse(extractedData['expiryDate']);
      if(expiryDate.isBefore(DateTime.now())){
           return false;
      }
      _token = extractedData['token'];
      _userId = extractedData['userId'];
      _expiryDate = expiryDate;
       _autoLogout();
       notifyListeners();
   }
   Future<void> signup (String email,String password) async {
     
     return authinticate( email, password, 'signUp');
   }

   Future<void> login(String email,String password)async{
        return authinticate( email, password, 'signInWithPassword');
   }
   void logout ()async{
     _token =null;
     _expiryDate =null;
     _userId = null;
     if(_authTimer!=null){
        _authTimer.cancel();
        _authTimer =null;
     }
     notifyListeners();
     final prefs = await SharedPreferences.getInstance();
     prefs.clear();// when you want to remove all shared prefrance value
   }
   void _autoLogout(){
     if(_authTimer !=null){
            _authTimer.cancel();
     }
     final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
     _authTimer = Timer(Duration(seconds:timeToExpiry ),logout);

   }
}