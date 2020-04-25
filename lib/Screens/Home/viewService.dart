import 'package:UQS/Screens/Home/livequeue.dart';
import 'package:UQS/Screens/Home/queue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';



class ViewService extends StatefulWidget {
  String displayName;
  String abbreviation;
  String email;
  String phoneNumber;
  String photoUrl;
  String address;
  num categoryIndex;
  num ticketCount;
  num ticketCountDone;
  String uid;
  ViewService({
    Key key,
    @required this.displayName,
    this.abbreviation,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.address,
    this.ticketCount,
    this.ticketCountDone,
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
      address,
      ticketCount,
      ticketCountDone,
      categoryIndex,
      uid);
}

class _ViewServiceState extends State<ViewService> {
  String displayName;
  String abbreviation;
  String email;
  String phoneNumber;
  String photoUrl;
  String address;
  num ticketCount;
  num ticketCountDone;
  num categoryIndex;
  String uid;

  _ViewServiceState(
    this.displayName,
    this.abbreviation,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.address,
    this.ticketCount,
    this.ticketCountDone,
    this.categoryIndex,
    this.uid,
  );

  int _currentValue = 0;

  Future onchangeValue() async {
    setState(() {
      _currentValue = 5;
    });
  }

  String title;

  @override
  Widget build(BuildContext context) {
    final screenData = MediaQuery.of(context);
    if (categoryIndex == 0) {
      title = "University";
    } else if (categoryIndex == 1) {
      title = "Government";
    } else if (categoryIndex == 2) {
      title = "Banks";
    }
    return Scaffold(
        body: Stack(children: <Widget>[
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: screenData.size.height / 1.5,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(16, 127, 246, 1),
              Color.fromRGBO(16, 127, 246, 1),
            ])),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
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
              Icons.chevron_left,
              color: Colors.white,
            ),
          )),
      Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: screenData.size.height / 2.5,
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
                  Text(title,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
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
                  Text(address,
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
                  Padding(
                    padding: EdgeInsets.all(screenData.size.width / 150),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LiveQueue(
                                    uid: uid, displayName: displayName)));
                          },
                          child: Container(
                            width: screenData.size.height / 5.5,
                            height: screenData.size.height / 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(16, 127, 246, 1),
                                  Color.fromRGBO(16, 127, 246, 1),
                                ])),
                            child: Center(
                                child: Text("Live Queue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Queue(
                                    ticketCountDone: ticketCountDone,
                                    ticketCount: ticketCount,
                                    displayName: displayName,
                                    abbreviation: abbreviation,
                                    photoUrl: photoUrl,
                                    uid: uid)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: screenData.size.height / 5.5,
                            height: screenData.size.height / 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(16, 127, 246, 1),
                                  Color.fromRGBO(16, 127, 246, 1),
                                ])),
                            child: Center(
                                child: Text("Queue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                          ),
                        )
                      ],
                    ),
                  ),
                ])),
          ))
    ]));
  }
}
