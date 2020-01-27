import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey =GlobalKey<FormState>();
  String password;
  String email;
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
          Container(
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.lightBlueAccent[100],
                letterSpacing: 2,
                fontSize: 20
              ),
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30,10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.all(
                Radius.circular(25)
              ),
              color: Colors.white,
            ),
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      onSaved: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'email@gmail.com',
                        labelText: "Email Address",
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      onSaved: (value) => password,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '6-12 characters',
                        labelText: "Password",
                        contentPadding: EdgeInsets.all(10)
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 100,right: 100),
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: () {
                        final form = formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print("$email $password");
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      'Log in with special providers',
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                      ),
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}