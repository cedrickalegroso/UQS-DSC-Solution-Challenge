import 'package:flutter/material.dart';
import 'Auth.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.redAccent[300],
    ),
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/AuthPage': (context) => AuthPage(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/register': (context) => Register(),
      '/accountSetup': (context) => AccountSetup(),
    },
    
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();


}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Unified Qeueing System',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey),
      ),
      seconds: 5,
      navigateAfterSeconds: AuthPage(),
      image: new Image.asset('assets/launch_image.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}
