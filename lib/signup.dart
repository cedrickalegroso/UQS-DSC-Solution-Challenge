import 'package:flutter/material.dart';
import 'package:uqsbeta/authservice.dart';
import 'package:uqsbeta/loading.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  String _password = '';
  String _email = '';
  String _name = '';
  String _phoneNumber = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
            body: Align(
              alignment: Alignment.bottomLeft,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                    ? 'Email address is required'
                                    : null,
                                onChanged: (val) {
                                  setState(() => _email = val.trim());
                                },
                                onSaved: (value) => _email = value.trim(),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'email@gmail.com',
                                  labelText: "Email Address",
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
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: '6-12 characters',
                                    labelText: "Password",
                                    contentPadding: EdgeInsets.all(8)),
                              ),
                            ),
                            SizedBox(height: 8),
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
                                  hintText: 'Complete name',
                                  labelText: "Complete name",
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: '11 digit phone number',
                                  labelText: "Phone number",
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
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
                                    dynamic result = await _auth.signUp(
                                        _email, _password, _name, _phoneNumber);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                      });
                                    } else {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/login');
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
              ),
            ));
  }
}
