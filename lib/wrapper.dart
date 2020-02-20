import 'package:flutter/material.dart';
import 'package:uqsbeta/Miscellaneous/loading.dart';
import 'package:uqsbeta/Screens/Home/home.dart';
import 'package:uqsbeta/Screens/login.dart';
import 'package:uqsbeta/Models/user.dart';
import 'package:uqsbeta/Services/authservice.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    //checking if user is logged in then return either authpage or homescreen
    //uses a streambuilder to build widgets according to the authentication state of the user
    return StreamBuilder<User>(
      stream: authService.authState,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            print('No user is logged in');
            return AuthPage();
          }
          print('User with uid: ${user.uid} is logged in');
          return Homepage();
        } else {
          return Container(
            child: Loading()
          );
        }
      },
    ); 
  }
}
