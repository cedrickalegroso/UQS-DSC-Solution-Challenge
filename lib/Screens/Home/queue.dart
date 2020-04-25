import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:UQS/Services/ticketDatabase.dart';
import 'package:numberpicker/numberpicker.dart';

class Queue extends StatefulWidget {
  String photoUrl;
  num ticketCount;
  num ticketCountDone;
  String uid;
  String abbreviation;
  String displayName;
  Queue(
      {Key key,
      @required this.photoUrl,
      this.ticketCount,
      this.ticketCountDone,
      this.uid,
      this.abbreviation,
      this.displayName});
  @override
  _QueueState createState() => _QueueState(
      photoUrl, ticketCount, ticketCountDone, uid, abbreviation, displayName);
}

class _QueueState extends State<Queue> {
  String photoUrl;
  num ticketCount;
  num ticketCountDone;
  String uid;
  String abbreviation;
  String displayName;
  _QueueState(this.photoUrl, this.ticketCount, this.ticketCountDone, this.uid,
      this.abbreviation, this.displayName);

  int _currentValue = 5;
  bool isEmailNotify = false;

  @override
  Widget build(BuildContext context) {
    final screenData = MediaQuery.of(context);
    var five = 5;
    var onqueue = '${ticketCount - ticketCountDone}';

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(children: <Widget>[
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
          top: screenData.size.height / 5,
          right: screenData.size.width / 19,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: CachedNetworkImage(
                    imageUrl: photoUrl,
                    width: 150.0,
                    height: 150.0,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50, left: 25),
                  child: Text(
                    '$onqueue People on queue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenData.size.height / 40),
                  ),
                )
              ]),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: screenData.size.height / 2.0,
          child: Container(
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Select a trigger"),
                  int.parse(onqueue) >= five
                      ? Container(
                          child: NumberPicker.integer(
                              initialValue: _currentValue,
                              minValue: 0,
                              maxValue: 20,
                              onChanged: (newValue) =>
                                  {setState(() => _currentValue = newValue)}),
                        )
                      : Column(
          
                          children: <Widget>[
                            SizedBox(height: 10.0),
                              Text(
                                "Trigger on this service is not applicable.\nonly services with 5 and above pending tickets.",
                              ),
                            ]),
                             SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Switch(
                        value: isEmailNotify,
                        onChanged: (value) =>
                            {setState(() => isEmailNotify = true)},
                        activeTrackColor: Colors.blue,
                        activeColor: Colors.blueAccent,
                      ),
                      Text('Email Notification'),
                    ],
                  ),
                   SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () async {
                      TicketDatabase(
                              trigger: _currentValue,
                              emailNotify: isEmailNotify,
                              ticketCount: ticketCount,
                              serviceUid: uid,
                              serviceAbbreviation: abbreviation)
                          .initTicket();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(16, 127, 246, 1),
                            Color.fromRGBO(16, 127, 246, .6),
                          ])),
                      child: Center(
                          child: Text("Queue",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                    ),
                  )
                ]),
          ),
        ),
      ]),
    );
  }
}
