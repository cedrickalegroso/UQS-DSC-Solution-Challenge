import 'package:flutter/material.dart';
import 'package:uqsbeta/Miscellaneous/loading.dart';
import 'package:uqsbeta/Services/authservice.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //used for form validation
  final _formKey = GlobalKey<FormState>();
  //creating an instance of the class AuthService
  final AuthService _auth = AuthService();
  String _password = '';
  String _email = '';
  String _name = '';
  String _phoneNumber = '';
  bool loading = false;
  bool _obscureText = true;
  //show snackbar method
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        'Error signing up. Please try again',
        style: TextStyle(fontSize: 15.0),
      ),
      duration: new Duration(seconds: 5),
      backgroundColor: Colors.red,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  // //func for showing loading screen
  // void _onLoading() {
  //   //uses the built in func for displaying a dialog widget
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return Loading();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Text(
              "UQS",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: loading == false
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
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
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'Sign up below',
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
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.white,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.left,
                                validator: (value) => value.isEmpty
                                    ? 'Please enter complete name'
                                    : null,
                                onChanged: (val) {
                                  setState(() => _name = val);
                                },
                                onSaved: (value) => _name = value,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  icon: Icon(Icons.person),
                                  hintText: 'Complete name',
                                  labelText: "Name *",
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.left,
                                validator: (value) => value.isEmpty
                                    ? 'Please enter phone number'
                                    : null,
                                onChanged: (val) {
                                  setState(() => _phoneNumber = val);
                                },
                                onSaved: (value) => _phoneNumber = value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  icon: Icon(Icons.phone),
                                  hintText: '11 digit phone number',
                                  labelText: "Phone number *",
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  filled: true,
                                  icon: Icon(Icons.email),
                                  hintText: 'Your email address',
                                  labelText: "Email Address *",
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.left,
                                validator: (value) => value.isEmpty
                                    ? 'Password is required'
                                    : null,
                                onChanged: (val) {
                                  setState(() => _password = val.trim());
                                },
                                onSaved: (value) => _password = value.trim(),
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: '6-12 characters',
                                    labelText: "Password *",
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        child: Icon(_obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    contentPadding: EdgeInsets.all(8)),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled:
                                    _password.isNotEmpty && _password != null,
                                autofocus: false,
                                textAlign: TextAlign.left,
                                validator: (value) => value != _password
                                    ? 'Password does not match'
                                    : null,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Please re-type password',
                                    labelText: "Re-type password *",
                                    contentPadding: EdgeInsets.all(8)),
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
                                  //using the built in func of validating forms, this returns false if form is invalid
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = !loading);
                                    //call the signup function from AuthService()
                                    dynamic result = await _auth.signUp(
                                        _email, _password, _name, _phoneNumber);

                                    if (result == null) {
                                      // call the snackbar and pass the error message as a param then show error message
                                      _showSnackBar();
                                      setState(() => loading = !loading);
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Loading());
  }
}
