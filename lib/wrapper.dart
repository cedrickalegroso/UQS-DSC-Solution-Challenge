import 'package:flutter/material.dart';
import 'package:UQS/Screens/Home/home.dart';
import 'package:UQS/Screens/login.dart';
import 'package:UQS/Models/user.dart';
import 'package:UQS/Services/authservice.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    //checking if user is logged in then return either authpage or homescreen
    //uses a streambuilder to build widgets according to the authentication state of the user
    return StreamBuilder<User>(
      stream: authService.authState,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        final User user = snapshot.data;
        if (user == null) {
          print('No user is logged in');
          return AuthPage();
        } else {
          print(
              'User with uid: ${user.uid}, email: ${user.email} is logged in');
          return Homepage();
        }
      },
    );
  }
}
