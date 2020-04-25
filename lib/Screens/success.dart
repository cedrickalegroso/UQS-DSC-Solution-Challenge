import 'package:flutter/material.dart';
import 'package:UQS/Miscellaneous/fadeAnimation.dart';


class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}


class _SuccessPageState extends State<SuccessPage> {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: Column(
            children: <Widget>[
              FadeAnimation(1, Container(
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.fill
                  )
                ),
                child: Stack(
                  children: <Widget> [
                    Positioned(
                      child: FadeAnimation(1.5, Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/authlogo.png')
                          )
                        )
                      )),
                    ),
                    Positioned(
                      child: FadeAnimation(1.10, Container(
                        child: Center(child: Text("You are all good! ", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)))
                      ))
                    ),
                    Positioned(
                      child: FadeAnimation(1.15, Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 100),
                        child: Center(child: Text("We sent you a verification email, please verify before using UQS.", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,) ,)
                      ))
                    )
                  ]
                )
              )),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget> [
                    GestureDetector(
                      onTap: () async {
                         Navigator.of(context)
                            .pushNamed('/login');
                      },
                      child: FadeAnimation(1.5, Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                               Color.fromRGBO(16, 127, 246, 1),
                               Color.fromRGBO(16, 127, 246, .6),
                            ]
                          )
                        ),
                        child: Center(
                          child: Text('Bring me to login', style: TextStyle(color: Colors.white, ))
                        ),
                      ))
                    )
                  ]
                ),
              )
            ],
      ),
    );
  }
}