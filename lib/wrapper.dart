import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Screens/home.dart';
import 'package:uqsbeta/Screens/login.dart';
import 'package:uqsbeta/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //accessing user data from the provider
    final user = Provider.of<User>(context); 
    print(user);
    //checking if user is logged in then return either authpage or homescreen
    if (user == null) {
      //proceed to authpage if not
      return AuthPage(); 
    } else {
      //proceed to homepage if logged in
      return Homepage(); 
    }
  }
}
