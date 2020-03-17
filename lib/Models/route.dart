import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uqsbeta/Screens/Home/home.dart';
import 'package:uqsbeta/Screens/Home/profilepage.dart';
import 'package:uqsbeta/Screens/login.dart';
import 'package:uqsbeta/Screens/signup.dart';
import 'package:uqsbeta/wrapper.dart';

//class for defining the route when the root widget is generated
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments; //to be used if passing of arguments during navigation is required

    switch (settings.name) {
      case '/wrapper': // @carl gin add ko di kay from splashscreen after 5 seconds ma navigate sya sa wrapper hehe
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/login':
        return MaterialPageRoute(builder: (_) => AuthPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => Homepage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profilepage());
      default:
        return MaterialPageRoute(builder: (_) => Wrapper());
    }
  }
}
//indi pa ko sure kung amo ni ang best way mag define routes for navigation
