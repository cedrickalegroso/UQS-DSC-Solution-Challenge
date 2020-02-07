import 'package:flutter/material.dart';
import 'package:uqsbeta/Miscellaneous/Splashscreen.dart';
import 'package:uqsbeta/Models/route.dart';
import 'package:uqsbeta/Services/authservice.dart';
import 'package:uqsbeta/Models/user.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //This is the root widget
  @override
  Widget build(BuildContext context) {
    //wrapped the root widget with streamprovider to grant the whole widget tree access to the data provided by the stream
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        //generates a predefined route
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.redAccent[300],
        ),
        home: Splashscreen(),
      ),
    );
  }
}
