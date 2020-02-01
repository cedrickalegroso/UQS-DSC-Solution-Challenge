import 'package:flutter/material.dart';
import 'package:uqsbeta/authservice.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
final _formKey = GlobalKey<FormState>();

final AuthService _auth = AuthService();
String _password = '';
String _email = '';
bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20,30,20,10),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Sign Up Now',
                        style: TextStyle(
                          wordSpacing: 3,
                          color: Colors.white,
                          fontSize: 45,
                          ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'huehuehue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          ),
                      ),
                    ],
                  ),
                ), 
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: false,
                      textAlign: TextAlign.left,
                      validator: (value) => value.isEmpty ? 'Email address is required' : null,
                      onChanged: (val) {
                        setState(() => _email = val);
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
                      validator: (value) => value.isEmpty ? 'Password is required' : null,
                      onChanged: (val) {
                        setState(() => _password = val);
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
                          dynamic result = await _auth.signUp(_email, _password);
                          if (result == null){
                            setState(() {
                              loading = false;
                            });
                          } else {
                            Navigator.of(context).pushReplacementNamed('/login');
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
    );
  }
}