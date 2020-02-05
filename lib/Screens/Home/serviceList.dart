import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Models/service.dart';
import 'package:uqsbeta/Screens/Home/serviceTiles.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    final services = Provider.of<List<Service>>(context) ?? [];
    print('Current number of services: '+ (services.length).toString());//for debugging lang
    //returns a ListView widget based on the list of services registered on the databased
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        return ServiceTile(service: services[index]);
      },
    );
  }
}
