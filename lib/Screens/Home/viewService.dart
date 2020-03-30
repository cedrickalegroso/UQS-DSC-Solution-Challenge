import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:UQS/Models/service.dart';
import 'package:UQS/Screens/Home/category/university.dart';
import 'package:UQS/Services/ticketDatabase.dart';

class ViewService extends StatefulWidget {
  String displayName;
  String abbreviation;
  String email;
  String phoneNumber;
  String photoUrl;
  num categoryIndex;
  num ticketCount;
  String uid;
  ViewService({
    Key key,
    @required this.displayName,
    this.abbreviation,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.ticketCount,
    this.categoryIndex,
    this.uid,
  }) : super(key: key);

  @override
  _ViewServiceState createState() => _ViewServiceState(
      displayName,
      abbreviation,
      email,
      phoneNumber,
      photoUrl,
      ticketCount,
      categoryIndex,
      uid);
}

class _ViewServiceState extends State<ViewService> {
  String displayName;
  String abbreviation;
  String email;
  String phoneNumber;
  String photoUrl;
  num ticketCount;
  num categoryIndex;
  String uid;

  _ViewServiceState(
    this.displayName,
    this.abbreviation,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.ticketCount,
    this.categoryIndex,
    this.uid,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 450,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
            image: DecorationImage(
                        image:
                            AssetImage('assets/$categoryIndex.png'),
                        fit: BoxFit.cover)
                ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
              child: CachedNetworkImage(
                imageUrl: photoUrl,
                width: 10.0,
                height: 50.0,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          )),
      Positioned(
          top: 50,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_left,
              color: Colors.white,
            ),
          )),
      Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 300,
          child: Container(
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text('University',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(displayName,
                      style: TextStyle(
                        color: Color.fromRGBO(97, 90, 90, 1),
                        fontSize: 25,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Lopez Jaena, Jaro Iloilo City',
                      style: TextStyle(
                        color: Color.fromRGBO(97, 90, 90, 1),
                        fontSize: 15,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(email,
                      style: TextStyle(
                        color: Color.fromRGBO(97, 90, 90, 1),
                        fontSize: 15,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(phoneNumber,
                      style: TextStyle(
                        color: Color.fromRGBO(97, 90, 90, 1),
                        fontSize: 15,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await TicketDatabase(
                              serviceUid: uid,
                              serviceAbbreviation: abbreviation)
                          .addTicket();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(16, 127, 246, 1),
                            Color.fromRGBO(16, 127, 246, .6),
                          ])),
                      child: Center(
                          child: Text("Create Ticket",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                    ),
                  )
                ])),
          ))
    ]));
  }
}
