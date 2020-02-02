import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uqsbeta/home.dart';
import 'package:uqsbeta/login.dart';
import 'package:uqsbeta/signup.dart';
import 'package:uqsbeta/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments; //to be used if passing of arguments during navigation is required

    switch (settings.name) {
      case '/login':
      return MaterialPageRoute(builder: (_) => AuthPage());
      case '/signup':
      return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/home':
      return MaterialPageRoute(builder: (_) => Homepage());
      default:
      return MaterialPageRoute(builder: (_) => Wrapper());
    }
  }
}