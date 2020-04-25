import 'dart:async';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

// new Splashscreen
class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5),
        () => Navigator.of(context).pushReplacementNamed('/onboard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.1,
              0.4,
              0.7,
              0.9
            ],
                colors: [
              Color(0xFF1080f6),
              Color(0xFF188af7),
              Color(0xFF269bfa),
              Color(0xFF2fa8fc),
            ])),
      ),
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Image.asset(
                  "assets/uqslogo.png",
                  scale: 20.0,
                ),
                /* Padding(padding: EdgeInsets.only(top: 20.0)),
                Text(
                  "Unified Queueing System",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ), */
              ])),
        ),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
                Padding(padding: EdgeInsets.only(bottom: 10.0)),
                Text(
                  'Long waiting is a thing in the past',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Beta 1.0.5',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ))
      ])
    ]));
  }
}
