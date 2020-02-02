import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/home.dart';
import 'package:uqsbeta/login.dart';
import 'package:uqsbeta/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //accessing user data from the provider
    print(user);
//checking if user is logged in then return either authpage or homescreen
    if (user == null) {
      
      return AuthPage(); //proceed to authpage if not
    } else {
      return Homepage(); //proceed to homepage if logged in
    }
  }
}
