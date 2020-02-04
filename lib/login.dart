import 'package:flutter/material.dart';
import 'package:uqsbeta/authservice.dart';
import 'package:uqsbeta/loading.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  String _password = '';
  String _email = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: true,
            backgroundColor: Colors.lightBlueAccent,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Container(
                          child: Column(
                            
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 50.0)),
 
                              Text(
                                'UQS',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                            Container(
                              padding: EdgeInsets.only(left: 100, right: 100),
                              child: RaisedButton(
                                color: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result = await _auth.signInEmail(
                                        _email, _password);
                                    if (result == null) {
                                      setState(() => loading = false);
                                    } else {
                                      Navigator.of(context).pushReplacementNamed('/home');
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
                                onTap: () {
                                  Navigator.of(context).pushNamed('/signup');
                                },
                                child: Text(
                                  'New user? Click here to Sign up',
                                  textAlign: TextAlign.center,
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
                                        //set loading to true to show loading screen while waiting for the result from firebaseauth
                                        setState(() => loading = true);
                                        //call the sign in function under AuthService()
                                        dynamic result = await _auth
                                            .signInEmail(_email, _password);
                                        if (result == null) {
                                          //set loading to false to return to sign in page if user fails to sign in
                                          setState(() => loading = false);
                                        } else {
                                          //proceeds to homepage otherwise
                                          Navigator.of(context)
                                              .pushReplacementNamed('/home');
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
