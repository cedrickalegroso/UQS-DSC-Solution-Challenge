import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Models/user.dart';
import 'package:uqsbeta/Screens/Home/customlisttile.dart';
import 'package:uqsbeta/Models/service.dart';
import 'package:uqsbeta/Screens/Home/serviceList.dart';
import 'package:uqsbeta/Screens/Home/userTile.dart';
import 'package:uqsbeta/Services/authservice.dart';
import 'package:uqsbeta/Services/serviceDatabase.dart';
import 'package:uqsbeta/Services/userDatabase.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    //create an instance based on the data from the stream
    //this is then used as parameter para mag set up sang stream para sa userData
    final user = Provider.of<User>(context);

    //wrapped the whole scaffold widget with streamprovider to grant the whole widget tree access to the data provided by the stream
    return MultiProvider(
      providers: [
        StreamProvider<List<Service>>.value(value: ServiceDatabase().service),
        StreamProvider<UserData>.value(value: DatabaseService(uid: user.uid).userData), 
      ],
      child: new Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: new AppBar(
          title: Text(""),
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0,
        ),
        //drawer
        drawer: new Drawer(
            child: new ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                Colors.lightBlueAccent,
                Colors.lightBlue,
                Colors.blueAccent,
              ])),
              child: UserTile(),
            ),
            CostumListile(Icons.person, 'Profile', () => {}),
            CostumListile(Icons.notifications, 'Notification', () => {}),
            CostumListile(Icons.settings, 'Settings', () => {}),
            CostumListile(Icons.help, 'Help', () => {}),
            CostumListile(Icons.lock, 'Log out', () async {
              //calls sign out function from AuthService()
              await _auth.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }),
          ],
        )),
        body: Container(decoration: BoxDecoration(), child: ServiceList()),
      ),
    );
  }
}

class Asdf extends StatelessWidget {
  const Asdf({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          elevation: 10,
        ),
        Text("Flutter", style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ],
    ));
  }
}
