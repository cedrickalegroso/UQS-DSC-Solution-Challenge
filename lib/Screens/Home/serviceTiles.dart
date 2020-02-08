import 'package:flutter/material.dart';
import 'package:uqsbeta/Models/service.dart';

class ServiceTile extends StatelessWidget {
  final Service service;
  ServiceTile({this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.all(2),
            //display an image obtained online (e.g. image uploaded when registering)
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage('${service.photoUrl}'),
                  )),
            ),
          ),
          //display the name of the service as text
          title: Text(service.displayName),
          //display the phoneNumber of the service as text
          subtitle: Text(service.phoneNumber),
        ),
      ),
    );
  }
}
