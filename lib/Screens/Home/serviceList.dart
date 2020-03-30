import 'package:UQS/Models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Miscellaneous/serviceCategory.dart';
import 'package:UQS/Models/service.dart';
import 'package:UQS/Screens/Home/category/billsBanks.dart';
import 'package:UQS/Screens/Home/category/government.dart';
import 'package:UQS/Screens/Home/ticketsWrapper.dart';
import 'package:UQS/Services/serviceDatabase.dart';
import 'package:UQS/Services/ticketDatabase.dart';
import 'package:UQS/Miscellaneous/profileClipper.dart';

import 'category/university.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  num _currentIndex = 0;
  bool _isSelected;

  int _selectedNaviation = 0;
  final _pageOptions = [
    University(),
    Government(),
    BillsBanks(),
  ];

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<List<Service>>(context) ?? [];

    final User user = Provider.of<User>(context);

    print(user.uid);

    print('Current number of services: ' + (services.length).toString());

    List<String> servicesCat = ["Universities", "Government", "Bills/Banks"];

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
                      fontSize: _isSelected ? 20 : 18,
                      fontWeight:
                          _isSelected ? FontWeight.bold : FontWeight.normal),
                )));
      }).toList();
    }

    //returns a ListView widget based on the list of services registered on the databased
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 600,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background01.png'),
                    fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 25,
                      right: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'UQS',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        ClipOval(
                          clipper: ProfileClipper(),
                          child: CachedNetworkImage(
                            imageUrl: '${user.photoUrl}',
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Services",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontFamily: 'Calibre-Semibold',
                            )),
                      ],
                    )),
                Row(
                  children: _buildServiceCat(_currentIndex),
                ),
                Expanded(child: _pageOptions[_selectedNaviation])
              ],
            ),
          )
        ]);
  }
}

class ServiceTile extends StatelessWidget {
  final Service service;
  ServiceTile({this.service, int index});

  //show snackbar method
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        'Ticket created succesfully',
        style: TextStyle(fontSize: 15.0),
      ),
      duration: new Duration(seconds: 5),
      backgroundColor: Colors.green,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return service != null
        ? Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('assets/stillbg.png'),
                      fit: BoxFit.cover)),
              child: Transform.translate(
                offset: Offset(50, -50),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 63),
                  child: CachedNetworkImage(
                    imageUrl: '${service.photoUrl}',
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          )
        : null;
  }
}

/*

       Expanded(
                  child: SizedBox(
                      height: 500.0,
                      child: GridView.builder(
                        physics: ScrollPhysics(),
                        itemCount: services.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          print('called $_currentIndex');
                          return StreamProvider<List<Service>>.value(
                            value: ServiceDatabase(categoryIndex: _currentIndex).service,
                            child: ServiceTile(service: services[index]),
                          );
                        },
                      )
                  ),
                )

*/
