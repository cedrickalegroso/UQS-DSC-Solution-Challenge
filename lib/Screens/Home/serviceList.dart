import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Models/service.dart';

class ServiceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final services = Provider.of<List<Service>>(context) ?? [];
    print('Current number of services: ' +
        (services.length).toString()); //for debugging lang
    //returns a ListView widget based on the list of services registered on the databased
    return GridView.builder(
      physics: ScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return ServiceTile(service: services[2]);
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
              child: CircleAvatar(
                backgroundImage: NetworkImage('${service.photoUrl}'),
                backgroundColor: Colors.transparent,
              ),
            ),
          )
        : null;
  }
}
