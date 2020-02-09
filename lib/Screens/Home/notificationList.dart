import 'package:flutter/material.dart';

class NotifList extends StatefulWidget {
  @override
  _NotifListState createState() => _NotifListState();
}

class _NotifListState extends State<NotifList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10,6,6,10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(2, 2),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.lightBlueAccent[100],
          ),
          child: ListTile(
            title: Text('Notification $index'),
            leading: Icon(Icons.notifications),
          ),
        );
      },
    );
  }
}
