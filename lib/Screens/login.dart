import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uqsbeta/Miscellaneous/loading.dart';
import 'package:uqsbeta/Services/authservice.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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

//func for showing loading screen
  // void _onLoading() {

  //     //uses the built in func for displaying a dialog widget
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return Loading();
  //       });

  // }

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
        backgroundColor: Colors.lightBlueAccent,
        body: loading == false
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Align(
                      //alignment: Alignment.topCenter,
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 30.0,
                              bottom: MediaQuery.of(context).size.height * 0.2),
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                                        setState(() => _email = val.trim());
                                      },
                                      onSaved: (value) => _email = value.trim(),
                                      keyboardType: TextInputType.emailAddress,
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
                                          contentPadding: EdgeInsets.all(6)),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 100, right: 100),
                                    child: RaisedButton(
                                      color: Colors.lightBlueAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: () async {
                                        //using the built in func of validating forms, this returns false if form is invalid
                                        if (_formKey.currentState.validate()) {
                                          AuthService _auth = AuthService();
                                          setState(() {
                                            loading = !loading;
                                          });
                                          //call the sign in function under AuthService()
                                          dynamic result = await _auth
                                              .signInEmail(_email, _password);

                                          if (result == null) {
                                            // call the snackbar and pass the error message as a param then show error message
                                            _showSnackBar();
                                            setState(() {
                                              loading = !loading;
                                            });
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
              )
            : Loading()
      )),
    );
  }
}
