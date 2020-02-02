import 'package:flutter/material.dart';
import 'package:uqsbeta/authservice.dart';

class Homepage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
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
            await _auth.signOut();
            Navigator.of(context).pushReplacementNamed('/login');
          }),
        ],
      )),
      body: Container(
          child: Center(
        child: Text("Home Page"),
      )),
    );
  }
}

class CostumListile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTop;
  CostumListile(this.icon, this.text, this.onTop);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        child: InkWell(
          splashColor: Colors.lightBlueAccent,
          onTap: onTop,
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
