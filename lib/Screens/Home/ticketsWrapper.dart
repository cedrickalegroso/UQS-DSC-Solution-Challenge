import 'package:UQS/Screens/Home/category/active.dart';
import 'package:UQS/Screens/Home/category/cancelled.dart';
import 'package:UQS/Screens/Home/category/done.dart';
import 'package:UQS/Models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Models/ticket.dart';
import 'package:UQS/Miscellaneous/profileClipper.dart';

class TicketsDashboard extends StatefulWidget {
  @override
  _TicketsDashboardState createState() => _TicketsDashboardState();
}

class _TicketsDashboardState extends State<TicketsDashboard> {
  int _currentIndex = 0;
  bool _isSelected;
  bool loading = false;

  int _selectedNaviation = 0;
  final _pageOptions = [
    ActivePage(),
    DonePage(),
    CancelledPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenData = MediaQuery.of(context);
    final tickets = Provider.of<List<Ticket>>(context) ?? [];
    final User user = Provider.of<User>(context);
    print('active tickets asdasdasda: ' + tickets.length.toString());
    print(user.name);
    List<String> servicesCat = ["Active", "Done", "Cancelled"];

    List<Widget> _buildServiceCat(num currentIndex) {
      return servicesCat.map((service) {
        var index = servicesCat.indexOf(service);
        _isSelected = _currentIndex == index;
        return Padding(
            padding: EdgeInsets.only(left: 25, right: 5),
            child: GestureDetector(
                onTap: () async {
                  setState(() {
                    _currentIndex = index;
                    _selectedNaviation = index;
                  });
                },
                child: Text(
                  service,
                  style: TextStyle(
                      color: _isSelected ? Colors.white : Colors.white70,
                      fontSize: _isSelected
                          ? screenData.size.height / 45
                          : screenData.size.height / 45,
                      fontWeight:
                          _isSelected ? FontWeight.bold : FontWeight.normal),
                )));
      }).toList();
    }

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenData.size.height,
            child: Container(
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(16, 127, 246, 1),
                Color.fromRGBO(16, 127, 246, 1),
              ])),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Tickets",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15.0, left: 20.0),
                            child: Text(user.name,
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                              margin: EdgeInsets.only(top: 10.0, right: 10),
                              child: ClipOval(
                                clipper: ProfileClipper(),
                                child: CachedNetworkImage(
                                  imageUrl: user.photoUrl,
                                  width: screenData.size.height / 20,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ))
                        ])
                  ]),
            )),
        Positioned(
          left: 0,
          right: screenData.size.width / 15,
          bottom: 0,
          height: screenData.size.height / 1.2 + 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildServiceCat(_currentIndex),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
                height: screenData.size.height / 1.2 ,
            child: Container(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: _pageOptions[_currentIndex])),
      ],
    ));
  }
}
