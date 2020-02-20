import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Miscellaneous/loading.dart';
import 'package:uqsbeta/Models/service.dart';
import 'package:uqsbeta/Models/ticket.dart';
import 'package:uqsbeta/Services/serviceDatabase.dart';

class Tickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<List<Ticket>>(context) ?? [];
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return StreamProvider<Service>.value(
          value: ServiceDatabase(uid: tickets[index].serviceUid).serviceData,
          child: ActiveTickets(tickets: tickets, index: index),
        );
      },
    );
  }
}

class ActiveTickets extends StatelessWidget {
  const ActiveTickets({
    Key key,
    @required this.tickets,
    @required this.index,
  }) : super(key: key);

  final List<Ticket> tickets;
  final int index;

  @override
  Widget build(BuildContext context) {
    Service service = Provider.of<Service>(context);
    return service != null
        ? Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(1),
            width: MediaQuery.of(context).size.width * .70,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: ListTile(
                    title: Text(
                      '${service.displayName}',
                      textAlign: TextAlign.left,
                    ),
                    leading: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * .05,
                      backgroundImage: NetworkImage('${service.photoUrl}'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: ListTile(
                    title: Text(
                      '${tickets[index].ticketNo}',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      'N persons before your turn',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Loading();
  }
}
