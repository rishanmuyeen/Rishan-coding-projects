import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationService{
  late GlobalKey<NavigatorState> _navigatorkey; 
   
  final Map<String, Widget Function(BuildContext)> _routes ={
    "/login" : (context) => LoginPage(),
    "/home" : (context) => HomePage(),
    "/register" : (context) => RegisterPage(),
  }; 
  
   Map<String, Widget Function(BuildContext)> get routes{
    return _routes;
   }

   GlobalKey<NavigatorState>? get navigatorKey{ 
    return _navigatorkey;
   }

  NavigationService(){
    _navigatorkey = GlobalKey<NavigatorState>(); 
  }
  void push(MaterialPageRoute route){
     _navigatorkey.currentState?.push(route);
  }

  void pushNamed(String routeName){
    _navigatorkey.currentState?.pushNamed(routeName);
  }

  void pushReplacmentNamed(String routeName){
    _navigatorkey.currentState?.pushReplacementNamed (routeName);
  } 

  void goBack(){
    _navigatorkey.currentState?.pop();
  }
} 