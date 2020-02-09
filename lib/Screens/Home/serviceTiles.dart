import 'package:flutter/material.dart';
import 'package:uqsbeta/Models/service.dart';

class ServiceTile extends StatelessWidget {
  final Service service;
  ServiceTile({this.service});

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Colors.lightBlueAccent,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('${service.photoUrl}'),
              )),
        ),
      ),
    );
        
  }
}