import 'package:UQS/Miscellaneous/loading.dart';
import 'package:UQS/Models/ticket.dart';

import 'package:UQS/Services/serviceDatabase.dart';
import 'package:UQS/Services/ticketDatabase.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Models/service.dart';

import '../viewticket.dart';

class ActivePage extends StatefulWidget {
  @override
  _ActivePageState createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  @override
  Widget build(BuildContext context) {
    final screenData = MediaQuery.of(context);
    final tickets = Provider.of<List<Ticket>>(context) ?? [];
    
    return tickets.length == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'No active tickets',
                style: TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            ],
          )
        : Container(
            height: screenData.size.height / 1.5,
            child: GridView.builder(
              physics: ScrollPhysics(),
              itemCount: tickets.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.3,
                  mainAxisSpacing: 0.3),
              itemBuilder: (context, index) {
                return StreamProvider<Service>.value(
                    value: ServiceDatabase(uid: tickets[index].serviceUid)
                        .serviceData,
                    child: ActiveTickets(tickets: tickets, index: index));
              },
            ),
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
    final screenData = MediaQuery.of(context);
    Service service = Provider.of<Service>(context);
    var ticketNo = '${tickets[index].ticketRaw}';
    var isalreadyNotified = '${tickets[index].alreadyNotified}';
    var istriggerNow = service.ticketCount - service.ticketCountDone;
    var trigger = '${tickets[index].trigger}';
    var refNo = '${tickets[index].refNo}';
 

    int.parse(trigger) == istriggerNow
        ? int.parse(isalreadyNotified) == 0 ? TicketDatabase().initNotify(refNo) : null
        : null;

    print(service.ticketCount );

    return service != null
        ? Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Container(
                    child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(16, 127, 246, 1),
                        Color.fromRGBO(16, 127, 246, 1),
                      ])),
                  child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                          top: 25,
                          left: 30,
                          right: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: CachedNetworkImage(
                                imageUrl: '${service.photoUrl}',
                                width: 86.0,
                                height: 86.0,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${tickets[index].ticketNo}',
                                      style: TextStyle(
                                          fontSize: screenData.size.height / 30,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '${tickets[index].ticketRaw - service.ticketCountDone} Person(s) before you',
                                      style: TextStyle(
                                          fontSize: screenData.size.height / 60,
                                          color: Colors.white),
                                    ),
                                  ]),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  size: 40.0,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewTicket(
                                          displayName: service.displayName,
                                          abbreviation: service.abbreviation,
                                          email: service.email,
                                          phoneNumber: service.phoneNumber,
                                          photoUrl: service.photoUrl,
                                          ticketCount: service.ticketCount,
                                          ticketNo: ticketNo,
                                          refNo: refNo,
                                          timestampDone: tickets[index].timestampDone,
                                          teller: tickets[index].teller,
                                          ticketRaw: tickets[index].ticketRaw,
                                          categoryIndex: service.categoryIndex,
                                          ticketdone: service.ticketCountDone,
                                          uid: service.uid)));
                                })
                          ],
                        )),
                  ]),
                )),
              ]))
        : Loading();
  }
}
