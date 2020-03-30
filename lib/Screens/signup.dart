import 'package:flutter/material.dart';
import 'package:UQS/Miscellaneous/loading.dart';
import 'package:UQS/Services/authservice.dart';
import 'package:UQS/Miscellaneous/fadeAnimation.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.white,
        body: loading == false
            ? SingleChildScrollView(
                    child: Column(
                      children: <Widget> [
                        FadeAnimation(1, Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/background.png'),
                              fit: BoxFit.fill
                            )
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                child: Center(child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),)
                                )
                              )
                            ]
                          ),
                        )),
                            Padding(
                            
                            padding: EdgeInsets.all(30.0),
                            child:  Column(
                              children: <Widget> [
                                Container(
                                    margin: EdgeInsets.only(top: 1),
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10)
                                      )
                                    ]
                                  ),
                                  child: Form(
                                     key: _formKey,
                                    child:  Column(
                                    children: <Widget>[                
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                           border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                        ),
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
                                          decoration: InputDecoration(
                                            filled: true,
                                            icon: Icon(Icons.person),
                                            border: InputBorder.none,
                                            hintText: 'Complete name',
                                            labelText: "Name *",
                                            hintStyle: TextStyle(color: Colors.grey[400])
                                          )
                                        ),
                                      ),
                                       Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(8.0),                                
                                        child: TextFormField(
                                          autofocus: false,
                                          textAlign: TextAlign.left,
                                          validator: (value) => value.isEmpty
                                                ? 'Please enter a valid email'
                                                : null,
                                          onChanged: (val) {
                                            setState(() => _email  = val.trim());
                                          },
                                          onSaved: (value) => _email = value.trim(),
                                          decoration: InputDecoration(
                                            filled: true,
                                            icon: Icon(Icons.email),
                                            border: InputBorder.none,
                                            labelText: "Email Address *",
                                            hintText: 'Your email address',
                                            hintStyle: TextStyle(color: Colors.grey[400])
                                          )
                                        ),
                                      ),

                                         Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(8.0),                                
                                        child: TextFormField(
                                          autofocus: false,
                                          textAlign: TextAlign.left,
                                          validator: (value) => value.isEmpty
                                                ? 'Please enter a valid phone number'
                                                : null,
                                          onChanged: (val) {
                                            setState(() => _phoneNumber = val.trim());
                                          },
                                          onSaved: (value) => _phoneNumber = value.trim(),
                                          decoration: InputDecoration(
                                            filled: true,
                                            icon: Icon(Icons.phone),
                                            border: InputBorder.none,
                                            labelText: "Phone Number *",
                                            hintText: 'Your phone number',
                                            hintStyle: TextStyle(color: Colors.grey[400])
                                          )
                                        ),
                                      ),
                                        Container(
                                           margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(8.0),                                
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
                                            border: InputBorder.none,
                                            labelText: "Password *",
                                            hintText: '6-12 characters',
                                            hintStyle: TextStyle(color: Colors.grey[400]),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                    _obscureText = !_obscureText;
                                                });
                                                },
                                                child: Icon(_obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off)),
                                          )
                                        ),
                                      )
                                    ]
                                  ), 
                                  )
                         
                                ),
                                SizedBox(height: 20,),
                               GestureDetector(
                                 onTap: () async {
                                      //using the built in func of validating forms, this returns false if form is invalid
                                        Navigator.of(context)
                                           .pushNamed('/successreg');
                                     if (_formKey.currentState.validate()) {
                                       setState(() => loading = !loading);
                                       // call the sign up function
                                      dynamic result = await _auth.signUp(
                                         _email, _password, _name, _phoneNumber);
                                       // if the result is null show snakcbar
                                         if (result == null ) {
                                           // call the snackbar to show error message
                                           _showSnackBar();
                                           setState(() => loading = !loading);
                                         } else {
                                         
                                         }
                                     }
                                    }, 
                                child: Container(
                                  height: 50,
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                       Color.fromRGBO(16, 127, 246, 1),
                                       Color.fromRGBO(16, 127, 246, .6),
                                      ] )
                                  ),
                                  child: Center(
                                    child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))                            
                                  ),
                                )),
                                Container(
                                   margin: EdgeInsets.only(top: 10),
                                  height: 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                      .pushNamed('/login');
                                    },
                                    child: Text("Already have an account?", style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold))
                                  )
                                )
                              ]
                            ),
                            )
                      ]
                    ),
              )
            : Loading());
  }
}


/*

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

  ==========

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

*/