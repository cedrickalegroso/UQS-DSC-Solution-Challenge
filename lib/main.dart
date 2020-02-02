import 'package:flutter/material.dart';
import 'package:uqsbeta/Splashscreen.dart';
import 'package:uqsbeta/authservice.dart';
import 'package:uqsbeta/home.dart';
import 'package:uqsbeta/models/user.dart';
import 'package:uqsbeta/signup.dart';
import 'login.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //This is the root widget
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      //wrapped the root widget to grant the whole widget tree access to the data provided by the stream
      value: AuthService().user,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/login': (_) => AuthPage(),
          '/signup': (_) => SignUpPage(),
          '/home': (_) => Homepage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.redAccent[300],
        ),
        home: Splashscreen(),
      ),
    );
  }
}
