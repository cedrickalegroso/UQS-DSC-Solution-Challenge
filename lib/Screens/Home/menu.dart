
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Miscellaneous/loading.dart';
import 'package:UQS/Models/ticket.dart';
import 'package:UQS/Models/user.dart';
import 'package:UQS/Models/notification.dart';
import 'package:UQS/Models/service.dart';
import 'package:UQS/Screens/Home/profilepage.dart';
import 'package:UQS/Screens/Home/serviceList.dart';
import 'package:UQS/Screens/Home/ticketsWrapper.dart';
import 'package:UQS/Services/serviceDatabase.dart';
import 'package:UQS/Services/ticketDatabase.dart';
import 'package:UQS/Services/userDatabase.dart';
import 'package:UQS/Services/notificationDatabase.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  int _selectedNaviation = 0;
  final _pageOptions = [
    TicketsDashboard(),
    ServiceList(),
    Profilepage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(16, 127, 246, 1),
            Color.fromRGBO(16, 127, 246, 1),
          ])),
          child: Stack(
            children: <Widget>[
              menu(context),
              dashboard(context),
            ],
          ),
        ));
  }

  Widget menu(context) {
     final User user = Provider.of<User>(context);
     print(user.name);
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
          
                FlatButton(
                  onPressed: () => {setState(() => _selectedNaviation = 0)},
                  child: Text("Tickets",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                FlatButton(
                  onPressed: () => {setState(() => _selectedNaviation = 1)},
                  child: Text("Services",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                FlatButton(
                  onPressed: () => {setState(() => _selectedNaviation = 2)},
                  child: Text("Profile",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(BuildContext context) {
    final screenData = MediaQuery.of(context);
    final User user = Provider.of<User>(context);
    return user != null
        ? MultiProvider(
            providers: [
                StreamProvider<List<Service>>.value(
                    value: ServiceDatabase().service),
                StreamProvider<List<UniversityCategory>>.value(
                    value: ServiceDatabase().universityCategory),
                StreamProvider<List<GovernmentCategory>>.value(
                    value: ServiceDatabase().governmentCategory),
                StreamProvider<List<BillsBanksCategory>>.value(
                    value: ServiceDatabase().billsbanksCategory),
                StreamProvider<List<Ticket>>.value(
                    value:
                        TicketDatabase(ticketOwnerUid: user.uid).activeTickets),
                StreamProvider<List<Done>>.value(
                    value:
                        TicketDatabase(ticketOwnerUid: user.uid).doneTickets),
                StreamProvider<List<Cancelled>>.value(
                    value: TicketDatabase(ticketOwnerUid: user.uid).cancelled),
                StreamProvider<User>.value(
                    value: DatabaseService(uid: user.uid).userData),
                StreamProvider<List<Notif>>.value(
                    value: NotificationDatabase(notifOwnerUid: user.uid)
                        .notification)
              ],
            child: AnimatedPositioned(
                duration: duration,
                top: 0,
                bottom: 0,
                left: isCollapsed ? 0 : 0.6 * screenWidth,
                right: isCollapsed ? 0 : -0.4 * screenWidth,
                child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Material(
                        animationDuration: duration,
                        elevation: 8,
                        color: backgroundColor,
                        child: SingleChildScrollView(
                            child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color.fromRGBO(16, 127, 246, 1),
                            Color.fromRGBO(16, 127, 246, 1),
                          ])),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 50),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      child:
                                          Icon(Icons.menu, color: Colors.white),
                                      onTap: () {
                                        setState(() {
                                          if (isCollapsed)
                                            _controller.forward();
                                          else
                                            _controller.reverse();

                                          isCollapsed = !isCollapsed;
                                        });
                                      },
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 15.0, top: 5.0),
                                        child: Row(children: <Widget>[
                                          Text("Jason",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontFamily: 'Calibre-Semibold',
                                              )),
                                          SizedBox(width: 10.0),
                                        ])),
                                  ],
                                ),
                                Container(
                                  height: screenData.size.height / 1.1,
                                  child: Scaffold(
                                    body: _pageOptions[_selectedNaviation],
                                  ),
                                )
                              ]),
                        ))))))
        : Loading();
  }
}
