import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();

}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();

  String _password;
  String _email;

  Object $User;

  // @carl gin saylo ko di ang validation

  // Bool to determing if the form is valid
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // called by on press submit
  void validateAndSubmit() async {
    // calls the form validation
    if (validateAndSave()) {
      try {
        // try to create the user
        AuthResult credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        return updateProfile(credentials
            .user); // call the Update profile so we can inject the data on database
      } catch (e) {
        // catch the error
        print(e); // print the error
      }
    } else {
      print("error!"); // Error if on validateSubmit returned false
    }
  }

  void updateProfile(user) {
    Firestore.instance.collection('users').add({
      // add the uid and the email in the firestore document ref
      'uid': user.uid,
      'email': user.email
    });
  }

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
          Row(
            children: <Widget>[
              Text('Welcome',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 50)),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Long waiting time is a thing in the past. come \nto your service whent its your turn',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 50, 30, 40),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
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
                      onSaved: (value) => _email = value,
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
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '6-12 characters',
                          labelText: "Password",
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 100, right: 100),
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: validateAndSubmit,
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


class Register extends StatelessWidget {
 final formKey = GlobalKey<FormState>();

  String _password;
  String _email;
  String _displayname;

  Object $User;

  // @carl gin saylo ko di ang validation

  // Bool to determing if the form is valid
  bool validateAndSaveRegister() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // called by on press submit
  void validateAndSubmitRegister() async {
    // calls the form validation
    if (validateAndSaveRegister()) {
      try {
        // try to create the user
        AuthResult credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        return updateProfile(credentials
            .user); // call the Update profile so we can inject the data on database
      } catch (e) {
        // catch the error
        print(e); // print the error
      }
    } else {
      print("error!"); // Error if on validateSubmit returned false
    }
  }

  void updateProfile(user) {
    Firestore.instance.collection('users').add({
      // add the uid and the email in the firestore document ref
      'uid': user.uid,
      'email': user.email,
    });
    
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            "UQS Register",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 50, 30, 40),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
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
                      onSaved: (value) => _email = value,
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
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '6-12 characters',
                          labelText: "Password",
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 100, right: 100),
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: validateAndSubmitRegister  ,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AccountSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Setup"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
