import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:UQS/Miscellaneous/loading.dart';
import 'package:UQS/Screens/Home/home.dart';
import 'package:UQS/Services/authservice.dart';
import 'package:UQS/Miscellaneous/fadeAnimation.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // color
  final color = const Color(0xff107ff6);
  //used for form validation
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  bool loading = false;

  //show snackbar method
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        'Error signing in. Please try again',
        style: TextStyle(fontSize: 15.0),
      ),
      duration: new Duration(seconds: 5),
      backgroundColor: Colors.red,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // @carl gin update ko dire nga part gin kuha ko na ang appbar kay pwedi ya ma click pabalik sa Screensplash
    //@cedrick pwede siya dyapon ma back pabalik sa splashscreen gamit ang navigational button sa dalom amo na gin update ko liwat.
    return WillPopScope(
      onWillPop: () => Future.value(false), //prevents going back to prev page
      child: SafeArea(
          //para d mag overlap ang screen kag ang UI ka android
          child: Scaffold(
              key: _scaffoldKey,
              //resizeToAvoidBottomInset: true,
              resizeToAvoidBottomPadding: true,
              backgroundColor: Colors.white,
              body: loading == false
                  ? SingleChildScrollView(
                      child: Column(children: <Widget>[
                        FadeAnimation(
                            1,
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/background.png'),
                                      fit: BoxFit.fill)),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: FadeAnimation(
                                        1.5,
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/authlogo.png'))),
                                        )),
                                  ),
                                  Positioned(
                                      child: FadeAnimation(
                                          1.10,
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Center(
                                                child: Text("Login",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ))))
                                ],
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(children: <Widget>[
                            FadeAnimation(
                                1.15,
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[100]))),
                                        child: TextFormField(
                                            autofocus: false,
                                            validator: (value) => value.isEmpty
                                                ? 'Email address is required'
                                                : null,
                                            onChanged: (val) {
                                              setState(
                                                  () => _email = val.trim());
                                            },
                                            onSaved: (value) =>
                                                _email = value.trim(),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]))),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                            autofocus: false,
                                            validator: (value) => value.isEmpty
                                                ? 'Password is required'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => _password = val);
                                            },
                                            onSaved: (value) =>
                                                _password = value.trim(),
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]))),
                                      )
                                    ]),
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  AuthService _auth = AuthService();

                                  dynamic result = await _auth.signInEmail(
                                      _email, _password);

                                  if (result == null) {
                                    _showSnackBar();
                                  } else {
                                    Navigator.of(context).pushNamed('/home');
                                  }
                                }
                              },
                              child: FadeAnimation(
                                  1.20,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(16, 127, 246, 1),
                                          Color.fromRGBO(16, 127, 246, .6),
                                        ])),
                                    child: Center(
                                        child: Text("Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold))),
                                  )),
                            ),
                            FadeAnimation(
                                1.20,
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 50,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('/signup');
                                        },
                                        child: Text("New User?",
                                            style: TextStyle(
                                                color: Colors.lightBlueAccent,
                                                fontWeight: FontWeight.bold)))))
                          ]),
                        )
                      ]),
                    )
                  : Loading())),
    );
  }
}

/* 

          child: Column(
                        children: <Widget>[
                          Align(
                            //alignment: Alignment.topCenter,
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: 30.0,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.2),
                                child: Text(
                                  'UQS',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          Align(
                            //alignment: Alignment.bottomCenter,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Text(
                                        'Welcome',
                                        style: TextStyle(
                                          wordSpacing: 3,
                                          color: Colors.white,
                                          fontSize: 45,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Text(
                                        'Long waiting time is a thing in the past. Come to your service when it\'s your turn.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: EdgeInsets.all(15),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: Colors.white,
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                            autofocus: false,
                                            textAlign: TextAlign.left,
                                            validator: (value) => value.isEmpty
                                                ? 'Email address is required'
                                                : null,
                                            onChanged: (val) {
                                              setState(
                                                  () => _email = val.trim());
                                            },
                                            onSaved: (value) =>
                                                _email = value.trim(),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              hasFloatingPlaceholder: false,
                                              hintText: 'email@gmail.com',
                                              labelText: "Email Address",
                                              contentPadding: EdgeInsets.all(6),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                            autofocus: false,
                                            textAlign: TextAlign.left,
                                            validator: (value) => value.isEmpty
                                                ? 'Password is required'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => _password = val);
                                            },
                                            onSaved: (value) =>
                                                _password = value.trim(),
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: '6-12 characters',
                                                labelText: "Password",
                                                contentPadding:
                                                    EdgeInsets.all(6)),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 100, right: 100),
                                          child: RaisedButton(
                                            color: Colors.lightBlueAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            onPressed: () async {
                                              //using the built in func of validating forms, this returns false if form is invalid
                                              if (_formKey.currentState
                                                  .validate()) {
                                                AuthService _auth =
                                                    AuthService();
                                                // setState(() {
                                                //   loading = !loading;
                                                // });
                                                //call the sign in function under AuthService()
                                                dynamic result =
                                                    await _auth.signInEmail(
                                                        _email, _password);

                                                if (result == null) {
                                                  // call the snackbar and pass the error message as a param then show error message
                                                  _showSnackBar();
                                                  // setState(() {
                                                  //   loading = !loading;
                                                  // });
                                                }
                                              }
                                            },
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: GestureDetector(
                                            //brings the user to the signup page when tapped
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed('/signup');
                                            },
                                            child: Text(
                                              'New user? Click here to Sign up',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

*/
