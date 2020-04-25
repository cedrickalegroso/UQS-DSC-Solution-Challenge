import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<Onboarding> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

    

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
  return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xFF1181f6),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenData = MediaQuery.of(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            height: screenData.size.height,
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                    Container(
                        height: screenData.size.height / 1.4,
                        child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                     SizedBox(height: screenData.size.height / 20,),
                                    Center(
                                        child: Image(
                                      image:
                                          AssetImage('assets/onboarding0.png'),
                                      width: screenData.size.height / 2.5,
                                    )),
                                    SizedBox(height:  screenData.size.height / 15,),
                                    Text(
                                      'Queue anytime, anywhere',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'By using UQS you can queue to any service that we support online no need to go to their office.',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                     SizedBox(height: screenData.size.height / 20,),
                                    Center(
                                        child: Image(
                                      image:
                                          AssetImage('assets/onboarding1.png'),
                                      width: screenData.size.height / 2.5,
                                    )),
                                    SizedBox(height: 30.0),
                                    Text(
                                      'Worry no more',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Yes you read that right! No need to stand or wait in-line UQS will notify you if your turn is near.',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                       SizedBox(height: screenData.size.height / 20,),
                                    Center(
                                        child: Image(
                                      image:
                                          AssetImage('assets/onboarding2.png'),
                                      width: screenData.size.height / 2.5,
                                    )),
                                    SizedBox(height: 30.0),
                                    Text(
                                      'Eco friendly ',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                        'By using Mobile to store your tickets, We can save a lot of trees and also make the waiting in-line a thing in the past.',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15))
                                  ],
                                ))
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    _currentPage != _numPages - 1
                        ? Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomRight,
                              child: FlatButton(
                                  onPressed: () {
                                    _pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Next',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22)),
                                      SizedBox(width: 10.0),
                                      Icon(Icons.arrow_forward,
                                          color: Colors.white, size: 30.0)
                                    ],
                                  )),
                            ),
                          )
                        : Text('')
                  ],
                ),
              ))),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ))),
              ),
            )
          : Text(''),
    );
  }
}
