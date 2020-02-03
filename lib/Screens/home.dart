import 'package:flutter/material.dart';
import 'package:uqsbeta/Miscellaneous/customlisttile.dart';
import 'package:uqsbeta/Services/authservice.dart';
//import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    //final service = Provider.of<List<Service>>(context);
    return new Scaffold(
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
              ])),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    elevation: 10,
                  ),
                  Text("Flutter",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ],
              )),
            ),
            CostumListile(Icons.person, 'Profile', () => {}),
            CostumListile(Icons.notifications, 'Notification', () => {}),
            CostumListile(Icons.settings, 'Settings', () => {}),
            CostumListile(Icons.help, 'Help', () => {}),
            CostumListile(Icons.lock, 'Log out', () async {
              //calls sign out function from AuthService()
              await _auth.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            }),
          ],
        )),
        body: Container(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                /*child: ListView.builder(
                  itemCount: service.length, //depende kung pila ka service ang ginapilahan ni user
                  itemBuilder: (context, index) {
                    return ServiceTile(service[index])
                  }
                )*/
              )
            ]),
          ),
        ));
  }
}
