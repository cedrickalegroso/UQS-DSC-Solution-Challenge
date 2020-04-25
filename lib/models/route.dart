import 'package:UQS/Screens/Home/livequeue.dart';
import 'package:UQS/Screens/Home/menu.dart';
import 'package:UQS/Screens/Home/queue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UQS/Screens/Home/home.dart';
import 'package:UQS/Screens/Home/profilepage.dart';
import 'package:UQS/Screens/Home/viewService.dart';
import 'package:UQS/Screens/login.dart';
import 'package:UQS/Screens/signup.dart';
import 'package:UQS/Screens/success.dart';
import 'package:UQS/Screens/onBoarding.dart';
import 'package:UQS/wrapper.dart';

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
      case '/successreg':
        return MaterialPageRoute(builder: (_) => SuccessPage());
      case '/onboard':
        return MaterialPageRoute(builder: (_) => Onboarding());
      case '/home':
        return MaterialPageRoute(builder: (_) => Homepage());
      case '/viewService':
        return MaterialPageRoute(builder: (_) => ViewService());
      case '/liveQueue':
        return MaterialPageRoute(builder: (_) => LiveQueue());
      case '/queue':
        return MaterialPageRoute(builder: (_) => Queue());
      case '/test':
        return MaterialPageRoute(builder: (_) => MenuDashboardPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profilepage());
      default:
        return MaterialPageRoute(builder: (_) => Wrapper());
    }
  }
}
//indi pa ko sure kung amo ni ang best way mag define routes for navigation
