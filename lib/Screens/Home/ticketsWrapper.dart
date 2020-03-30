import 'dart:developer';

import 'package:UQS/Models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Miscellaneous/loading.dart';
import 'package:UQS/Models/ticket.dart';
import 'package:UQS/Models/service.dart';
import 'package:UQS/Services/serviceDatabase.dart';
import 'package:UQS/Miscellaneous/profileClipper.dart';
import 'package:UQS/Miscellaneous/fadeAnimation.dart';

import 'package:UQS/Miscellaneous/data.dart'; // test

class TicketsDashboard extends StatefulWidget {
  @override
  _TicketsDashboardState createState() => _TicketsDashboardState();
}

class _TicketsDashboardState extends State<TicketsDashboard> {
  int _currentIndex = 0;
  bool _isSelected;
  bool loading = false;

  List<String> services = ["Univerities", "Government", "Bills/Banks"];

  List<Widget> _buildServiceCat(num currentIndex) {
    return services.map((service) {
      var index = services.indexOf(service);
      _isSelected = _currentIndex == index;
      return Padding(
          padding: EdgeInsets.only(left: 25, right: 5),
          child: GestureDetector(
              onTap: () async {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: Text(
                service,
                style: TextStyle(
                    color: _isSelected ? Colors.white : Colors.white70,
                    fontSize: _isSelected ? 20 : 18,
                    fontWeight:
                        _isSelected ? FontWeight.bold : FontWeight.normal),
              )));
    }).toList();
  }

  var currentPage = images.length - 1.0;
  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<List<Ticket>>(context) ?? [];
    final User user = Provider.of<User>(context);
    print('active tickets asdasdasda: ' + tickets.length.toString());

    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 600,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background01.png'),
                  fit: BoxFit.fill)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 25,
                      right: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'UQS',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        ClipOval(
                          clipper: ProfileClipper(),
                          child: CachedNetworkImage(
                            imageUrl: '${user.photoUrl}',
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text("Tickets",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontFamily: 'Calibre-Semibold',
                              )))
                    ],
                  ),
                ),
                Expanded(
                    child: GridView.builder(
                  physics: ScrollPhysics(),
                  itemCount: tickets.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 0.1),
                  itemBuilder: (context, index) {
                    return StreamProvider<Service>.value(
                        value: ServiceDatabase(uid: tickets[index].serviceUid)
                            .serviceData,
                        child: ActiveTickets(tickets: tickets, index: index));
                  },
                ))
              ]),
        )
      ],
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
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/${service.categoryIndex}.png'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                              top: 30,
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
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${tickets[index].ticketNo}',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              ],
                            )),
                      ]),
                    ))
              ])
        : Loading();
  }
}

/*
class Tickets extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  Tickets(this.currentPage);

  var cardAspectRatio = 12.0 / 16.0;
  var widgetAspectRatio = 0.75 * 1.2;

  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<List<Ticket>>(context) ?? [];

    return tickets.length != 0
        ? new AspectRatio(
            aspectRatio: widgetAspectRatio,
            child: LayoutBuilder(builder: (context, contraints) {
              var width = contraints.maxWidth;
              var height = contraints.maxHeight;

              var safeWidth = width - 2 * padding;
              var safeHeight = height - 2 * padding;

              var heightOfPrimaryCard = safeHeight;
              var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

              var primaryCardLeft = safeWidth - widthOfPrimaryCard;
              var horizontalInset = primaryCardLeft / 2;

              List<Widget> cardList = new List();

              for (var i = 0; i < tickets.length; i++) {
                var delta = i - currentPage;
                bool isOnRight = delta > 0;

                var start = padding +
                    max(
                        primaryCardLeft -
                            horizontalInset * -delta * (isOnRight ? 15 : 1),
                        0.0);

                var cardItem = Positioned.directional(
                  top: padding + verticalInset * max(-delta, 0.0),
                  bottom: padding + verticalInset * max(-delta, 0.0),
                  start: start,
                  textDirection: TextDirection.rtl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3.0, 6.0),
                                blurRadius: 10.0)
                          ]),
                      child: AspectRatio(
                        aspectRatio: cardAspectRatio,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/stillbg.png'),
                                      fit: BoxFit.fill)),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: Text('${tickets[i].ticketNo}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            fontFamily: "SF-Pro-Text-Regular")),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, bottom: 12.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Text("Ticket Information",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                cardList.add(cardItem);
              }

              return Stack(
                children: cardList,
              );
            }),
          )
        : new AspectRatio(
            aspectRatio: widgetAspectRatio,
            child: LayoutBuilder(builder: (context, contraints) {
              var width = contraints.maxWidth;
              var height = contraints.maxHeight;

              var safeWidth = width - 2 * padding;
              var safeHeight = height - 2 * padding;

              var heightOfPrimaryCard = safeHeight;
              var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

              var primaryCardLeft = safeWidth - widthOfPrimaryCard;
              var horizontalInset = primaryCardLeft / 2;

              List<Widget> cardList = new List();

              for (var i = 0; i < images.length; i++) {
                var delta = i - currentPage;
                bool isOnRight = delta > 0;

                var start = padding +
                    max(
                        primaryCardLeft -
                            horizontalInset * -delta * (isOnRight ? 15 : 1),
                        0.0);

                var cardItem = Positioned.directional(
                  top: padding + verticalInset * max(-delta, 0.0),
                  bottom: padding + verticalInset * max(-delta, 0.0),
                  start: start,
                  textDirection: TextDirection.rtl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3.0, 6.0),
                                blurRadius: 10.0)
                          ]),
                      child: AspectRatio(
                        aspectRatio: cardAspectRatio,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/stillbg.png'),
                                      fit: BoxFit.fill)),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: Text(title[i],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            fontFamily: "SF-Pro-Text-Regular")),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, bottom: 12.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Text("Ticket Information",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                cardList.add(cardItem);
              }
              return Stack(
                children: cardList,
              );
            }),
          );
  }
} 
*/
