import 'package:flutter/material.dart';
import 'package:uqsbeta/Screens/Home/home.dart';
import 'package:uqsbeta/Screens/login.dart';
import 'package:uqsbeta/Models/user.dart';
import 'package:uqsbeta/Services/authservice.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    //checking if user is logged in then return either authpage or homescreen
    return StreamBuilder<User>(
      stream: authService.user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        final User user = snapshot.data;

        if (user == null) {
          print('No user is logged in');
          return AuthPage();
        }
        print('User with uid: ${user.uid} is logged in');
        return Homepage(uid: user.uid);
      },
    ); //user != null ? Homepage(uid: user.uid) : AuthPage(); //=> if true, the data of user is passed to Homepage
  }
}
