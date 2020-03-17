import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Models/service.dart';
import 'package:uqsbeta/Services/ticketDatabase.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    final services = Provider.of<List<Service>>(context) ?? [];
    print('Current number of services: ' + (services.length).toString());

    //returns a ListView widget based on the list of services registered on the databased
    return GridView.builder(
      physics: ScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return ServiceTile(service: services[index]);
      },
    );
  }
}

class ServiceTile extends StatelessWidget {
  final Service service;
  ServiceTile({this.service});

  @override
  Widget build(BuildContext context) {
    return service != null
        ? Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(2, 2),
                )
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () async {
                  print(service.uid);
                  await TicketDatabase(
                          serviceUid: service.uid,
                          serviceAbbreviation: service.abbreviation)
                      .addTicket();
                },
                child: CircleAvatar(
                  // backgroundImage: NetworkImage('${service.photoUrl}'),
                  child: CachedNetworkImage(
                    imageUrl: '${service.photoUrl}',
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  backgroundColor: Colors.transparent,
                  // child: IconButton(
                  //     icon: Icon(Icons.add),
                  //     alignment: Alignment.bottomRight,
                  //     onPressed: () async {
                  //       print(service.uid);
                  //       await TicketDatabase(
                  //               serviceUid: service.uid,
                  //               serviceAbbreviation: service.abbreviation)
                  //           .addTicket();
                  //     }),
                ),
              ),
            ),
          )
        : null;
  }
}
