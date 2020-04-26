import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LiveQueue extends StatefulWidget {
  String uid;
  String displayName;

  LiveQueue({Key key, @required this.uid, this.displayName}) : super(key: key);

  @override
  _LiveQueueState createState() => _LiveQueueState(uid, displayName);
}

class _LiveQueueState extends State<LiveQueue> {
  String uid;
  String displayName;

  Future<List> liveqeue;

  Future<List> getLiveQueue() async {
    var response = await Dio().get(
        'https://us-central1-theuqs-52673.cloudfunctions.net/app/api/latestTicketDone/$uid');
    return response.data;
  }

  @override
  void initState() {
    liveqeue = getLiveQueue();
    super.initState();
  }

  _LiveQueueState(this.uid, this.displayName);

  @override
  Widget build(BuildContext context) {
    print(displayName);
    final screenData = MediaQuery.of(context);
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
                Icons.arrow_left,
                color: Colors.white,
              ),
            )),
        Positioned(
            top: 65,
            right: 10,
            child: Text(
              displayName,
              style: TextStyle(color: Colors.white),
            )),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: screenData.size.height / 1.2,
            child: Container(
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: FutureBuilder<List>(
                future:
                    liveqeue, // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text( 'Teller: ' +
                                  snapshot.data[index]['teller'].toString(),
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: screenData.size.height / 50, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data[index]['ticketNo'],
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: screenData.size.height / 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10.0)
                              ]);
                        });
                  } else {
                    return Text('loading service queue');
                  }
                },
              ),
            )),
      ]),
    );
  }
}
