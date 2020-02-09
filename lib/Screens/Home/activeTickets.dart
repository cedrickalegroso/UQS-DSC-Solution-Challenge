import 'package:flutter/material.dart';

class Tickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(1),
          width: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(2, 2),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: ListTile(
                  title: Text('ServiceName $index', textAlign: TextAlign.left,),
                  leading: Icon(Icons.school),
                ),
              ),
              SizedBox(height: 12),
              Flexible(
                flex: 4,
                child: Text(
                  'C0123',
                  style: TextStyle(
                    letterSpacing: 2,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 3,
                child: Text(
                  'N persons before your turn',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
