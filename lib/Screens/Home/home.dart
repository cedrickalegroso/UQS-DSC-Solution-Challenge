import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Models/user.dart';
import 'package:uqsbeta/Screens/Home/activeTickets.dart';
import 'package:uqsbeta/Screens/Home/customlisttile.dart';
import 'package:uqsbeta/Models/service.dart';
import 'package:uqsbeta/Screens/Home/notificationList.dart';
import 'package:uqsbeta/Screens/Home/serviceList.dart';
import 'package:uqsbeta/Screens/Home/userTile.dart';
import 'package:uqsbeta/Services/authservice.dart';
import 'package:uqsbeta/Services/serviceDatabase.dart';
import 'package:uqsbeta/Services/userDatabase.dart';

class Homepage extends StatefulWidget {
  final uid;
  Homepage({this.uid});
  @override
  _HomepageState createState() => _HomepageState(uid);
}

class _HomepageState extends State<Homepage> {
  dynamic uid;

  _HomepageState(this.uid);
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    //create an instance based on the data from the stream
    //this is then used as parameter para mag set up sang stream para sa userData
   

    //wrapped the whole scaffold widget with streamprovider to grant the whole widget tree access to the data provided by the stream
    return MultiProvider(
      providers: [
        StreamProvider<List<Service>>.value(value: ServiceDatabase().service),
        StreamProvider<UserData>.value(
            value: DatabaseService(uid:uid).userData),
      ],
      child: SafeArea(
        child: new Scaffold(
          extendBody: true,
            appBar: PreferredSize(preferredSize: Size.fromHeight(20),child: AppBar(backgroundColor: Colors.transparent, elevation: 0)),
            resizeToAvoidBottomPadding: true,
            backgroundColor: Colors.lightBlueAccent,
            drawer: Drawer(child: DrawerList(auth: _auth)),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading:
                      Icon(Icons.bookmark, color: Colors.lightBlueAccent[100]),
                  title: Text(
                    "Active Tickets",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent[100]),
                  ),
                ),
                Flexible(flex: 2, child: Tickets()),
                ListTile(
                  leading:
                      Icon(Icons.bookmark, color: Colors.lightBlueAccent[100]),
                  title: Text(
                    "Notifications",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent[100]),
                  ),
                ),
                Flexible(flex: 3, child: NotifList()),
                ListTile(
                  leading:
                      Icon(Icons.bookmark, color: Colors.lightBlueAccent[100]),
                  title: Text(
                    "UQS Supported Services",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent[100]),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    height: 150,
                    color: Colors.white,
                    child: ServiceList()),
              ],
            )),
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    Key key,
    @required AuthService auth,
  })  : _auth = auth,
        super(key: key);

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          curve: Curves.fastOutSlowIn,
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
          Navigator.pop(context);
        }),
      ],
    );
  }
}
