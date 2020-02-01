import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:uqsbeta/wrapper.dart';



class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: new Text(
        'Unified Qeueing System',
        style: new TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20.0,
        color: Colors.grey),
        
      ),
      
      seconds: 5,
      navigateAfterSeconds: Wrapper(),
      image: new Image.asset('assets/launch_image.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,  
    );
  }
}