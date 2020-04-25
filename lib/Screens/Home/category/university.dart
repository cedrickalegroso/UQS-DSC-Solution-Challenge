import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Screens/Home/viewService.dart';
import 'package:UQS/Models/service.dart';

import 'package:UQS/Services/serviceDatabase.dart';

class University extends StatefulWidget {
  @override
  _UniversityState createState() => _UniversityState();
}

class _UniversityState extends State<University> {
  @override
  Widget build(BuildContext context) {
    print('university');
    final services = Provider.of<List<UniversityCategory>>(context) ?? [];
    return Container(
      height: 600,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage('assets/univ.png'), fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(.2),
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Universities",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: GridView.builder(
                  physics: ScrollPhysics(),
                  itemCount: services.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.1,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return StreamProvider<List<UniversityCategory>>.value(
                      value: ServiceDatabase().universityCategory,
                      child: UniversityTile(service: services[index]),
                    );
                  }))
        ],
      ),
    );
  }
}

class UniversityTile extends StatelessWidget {
  final UniversityCategory service;
  UniversityTile({this.service, int index});

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
        ? Container(
            
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                     gradient: LinearGradient(colors: [
                            Color.fromRGBO(16, 127, 246, 1),
                            Color.fromRGBO(16, 127, 246, 1),
                          ])),
                child: Container(
         
                  child: Transform.translate(
                      offset: Offset(0, -0),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewService(
                                  displayName: service.displayName,
                                  abbreviation: service.abbreviation,
                                  email: service.email,
                                  phoneNumber: service.phoneNumber,
                                  photoUrl: service.photoUrl,
                                  ticketCount: service.ticketCount,
                                  ticketCountDone: service.ticketCountDone,
                                  address: service.address,
                                  categoryIndex: service.categoryIndex,
                                  uid: service.uid)));
                        },
                        child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: '${service.photoUrl}',
                                  width: 90.0,
                                  height: 90.0,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '${service.abbreviation}',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                  ),
                                )
                              ]),
                        ),
                      )),
                ),
              ),
            ))
        : null;
  }
}
