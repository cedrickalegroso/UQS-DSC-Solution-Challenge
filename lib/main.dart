import 'package:flutter/material.dart';
import 'package:uqsbeta/Splashscreen.dart';
import 'package:uqsbeta/authservice.dart';
import 'package:uqsbeta/models/user.dart';
import 'package:uqsbeta/route.dart';
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
