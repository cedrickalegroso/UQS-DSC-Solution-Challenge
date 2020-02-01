import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uqsbeta/models/user.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();

  String _password;
  String _email;

  Object $User;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create a user object based on a user from the database
  User _userFromFireBaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInEmail() async {
    if (validateAndSave()) {
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        print("user with UID " + user.uid);
        print("signed in");
        
        return _userFromFireBaseUser(user);//calls the user object based from the firebase then return the uid of the user
      }catch (e) {
        print(e);
        return null;
      }
    } else {
      print("invalid input");
    }
    
    
    
  }
 
  // @carl gin saylo ko di ang validation 
  
  // Bool to determing if the form is valid
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    } else {
      return false;
    }

  }

  // called by on press submit 
  void validateAndSubmit() async  {
    // calls the form validation
   if(validateAndSave()) {
     try{ // try to create the user
      AuthResult credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:_email, password: _password);
      return updateProfile(credentials.user); // call the Update profile so we can inject the data on database
    }catch (e) { // catch the error 
       print(e); // print the error 
     }
   } else {
     print("error!"); // Error if on validateSubmit returned false
   }

  }

  void updateProfile(user) {
     
    Firestore.instance.collection('users').add({ // add the uid and the email in the firestore document ref
      'uid': user.uid,
      'email': user.email
     }    
    );
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
                        'Welcome',
                        style: TextStyle(
                          wordSpacing: 3,
                          color: Colors.white,
                          fontSize: 45,
                          ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Long waiting time is a thing in the past. Come to your service when it\'s your turn.',
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
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      validator: (value) => value.isEmpty ? 'Email address is required' : null,
                      onSaved: (value) => _email = value,
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
                      textAlign: TextAlign.left,
                      validator: (value) => value.isEmpty ? 'Password is required' : null,
                      onSaved: (value) => _password = value,
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
                      onPressed: signInEmail,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    child: Text(
                      'Log in with special providers',
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
