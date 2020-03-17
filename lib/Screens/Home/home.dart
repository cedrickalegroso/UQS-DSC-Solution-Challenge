import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Miscellaneous/loading.dart';
import 'package:uqsbeta/Models/ticket.dart';
import 'package:uqsbeta/Models/user.dart';
import 'package:uqsbeta/Screens/Home/activeTickets.dart';
import 'package:uqsbeta/Screens/Home/customlisttile.dart';
import 'package:uqsbeta/Models/service.dart';
import 'package:uqsbeta/Screens/Home/notificationList.dart';
import 'package:uqsbeta/Screens/Home/serviceList.dart';
import 'package:uqsbeta/Screens/Home/userTile.dart';
import 'package:uqsbeta/Services/authservice.dart';
import 'package:uqsbeta/Services/serviceDatabase.dart';
import 'package:uqsbeta/Services/ticketDatabase.dart';
import 'package:uqsbeta/Services/userDatabase.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    //wrapped the whole scaffold widget with streamprovider to grant the whole widget tree access to the data provided by the stream
    return user != null
        ? MultiProvider(
            providers: [
              StreamProvider<List<Service>>.value(
                  value: ServiceDatabase().service),
              StreamProvider<List<Ticket>>.value(
                  value:
                      TicketDatabase(ticketOwnerUid: user.uid).activeTickets),
              StreamProvider<User>.value(
                  value: DatabaseService(uid: user.uid).userData)
            ],
            child: SafeArea(
              child: new Scaffold(
                  extendBody: true,
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(25),
                      child: AppBar(
                          backgroundColor: Colors.transparent, elevation: 0)),
                  resizeToAvoidBottomPadding: true,
                  backgroundColor: Colors.lightBlueAccent,
                  drawer: Drawer(child: DrawerList()),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.bookmark,
                            color: Colors.lightBlueAccent[100]),
                        title: Text(
                          "Active Tickets",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent[100]),
                        ),
                      ),
                      Flexible(fit: FlexFit.loose, child: Tickets()),
                      ListTile(
                        leading: Icon(Icons.bookmark,
                            color: Colors.lightBlueAccent[100]),
                        title: Text(
                          "Notifications",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent[100]),
                        ),
                      ),
                      Flexible(fit: FlexFit.loose, child: NotifList()),
                      ListTile(
                        leading: Icon(Icons.bookmark,
                            color: Colors.lightBlueAccent[100]),
                        title: Text(
                          "UQS Supported Services",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent[100]),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                            color: Colors.white, child: ServiceList()),
                      ),
                    ],
                  )),
            ),
          )
        : Loading();
  }
}

class DrawerList extends StatelessWidget {
  final AuthService _auth = AuthService();
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
        CostumListile(Icons.person, 'Profile', () {
          Navigator.popAndPushNamed(context, '/profile');
        }),
        CostumListile(Icons.notifications, 'Notification', () => {}),
        CostumListile(Icons.settings, 'Settings', () => {}),
        CostumListile(Icons.help, 'Help', () => {}),
        CostumListile(Icons.lock, 'Log out', () async {
          //calls sign out function from AuthService()
          await _auth.signOut().then((result) => {Navigator.pop(context)});
        }),
      ],
    );
  }
}

/*Future<bool> showAlertDialog(BuildContext context) async {
  dynamic signout;
  // set up the button
  Widget okButton = FlatButton(
    child: Text("Ok"),
    onPressed: () {Navigator.pop(context,true);},
  );
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {Navigator.pop(context,false);},
  );
  
  // set up the AlertDialog
  signout = AlertDialog(
    title: Text("Signout"),
    content: Text("Are you sure you want to signout?"),
    actions: [
      okButton,
      cancelButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}*/
