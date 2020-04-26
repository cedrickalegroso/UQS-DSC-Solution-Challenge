import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:UQS/Services/ticketDatabase.dart';
import 'package:dio/dio.dart';

class ViewTicket extends StatefulWidget {
  String displayName;
  String abbreviation;
  String email;
  String phoneNumber;
  String photoUrl;
  num categoryIndex;
  num ticketCount;
  num ticketdone;
  num teller;
  num ticketRaw;
  num timestampDone;
  String ticketNo;
  String refNo;
  String uid;

  ViewTicket({
    Key key,
    @required this.displayName,
    this.abbreviation,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.ticketCount,
    this.categoryIndex,
    this.ticketNo,
    this.refNo,
    this.uid,
    this.teller,
    this.timestampDone,
    this.ticketRaw,
    this.ticketdone,
  }) : super(key: key);

  @override
  _ViewTicketState createState() => _ViewTicketState(
      displayName,
      abbreviation,
      email,
      phoneNumber,
      photoUrl,
      ticketCount,
      ticketNo,
      categoryIndex,
      refNo,
      uid,
      teller,
      ticketRaw,
      timestampDone,
      ticketdone);
}

class _ViewTicketState extends State<ViewTicket> {
  String displayName;
  String abbreviation;
  String email;
  String phoneNumber;
  String photoUrl;
  String ticketNo;
  num ticketCount;
  num categoryIndex;
  String refNo;
  String uid;
  num teller;
  num ticketRaw;
  num ticketdone;
  num timestampDone;

  _ViewTicketState(
      this.displayName,
      this.abbreviation,
      this.email,
      this.phoneNumber,
      this.photoUrl,
      this.ticketCount,
      this.ticketNo,
      this.categoryIndex,
      this.refNo,
      this.uid,
      this.teller,
      this.ticketRaw,
        this.timestampDone,
      this.ticketdone);

  Future<List> timelines;

  Future<List> getTimelines() async {
    print('tiggreeeddd');
    var response = await Dio().get(
        'https://us-central1-theuqs-52673.cloudfunctions.net/app/api/timeline/$refNo');
    return response.data;
  }

  @override
  void initState() {
    timelines = getTimelines();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenData = MediaQuery.of(context);
    final diff = ticketRaw - ticketdone;
    return Scaffold(
        body: Stack(children: <Widget>[
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  CachedNetworkImage(
                    imageUrl: photoUrl,
                    width: 150.0,
                    height: 150.0,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: screenData.size.height / 50),
                  Text(ticketNo,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenData.size.height / 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.0),
                  Text(displayName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenData.size.height / 35,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.0),
                  Text('$diff person(s) before you',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.0),

                  Text(
                      teller == 0
                          ? 'Teller: No Teller Please wait'
                          : 'Teller: $teller',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
         
                  GestureDetector(
                    onTap: () async {
                      await TicketDatabase(refNo: refNo).cancelTicket();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(171, 31, 21, 1),
                            Color.fromRGBO(128, 18, 10, .6),
                          ])),
                      child: Center(
                        child: Text("Cancel Ticket",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
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
          height: 200,
          child: Container(
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text('Timeline',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 200.0,
                    child: FutureBuilder<List>(
                      future:
                          timelines, // a previously-obtained Future<String> or null
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(snapshot.data[index]['message']),
                                      SizedBox(height: 10.0)
                                    ]);
                              });
                        } else {
                          return Text('loading ticket timeline');
                        }
                      },
                    ),
                  ))
                ])),
          )),
    ]));
  }
}
