
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:UQS/Models/service.dart';

class ServiceNotifier with ChangeNotifier {
  List<Service> _serviceList = [];
  Service _currentService;

  UnmodifiableListView<Service> get servicelist => UnmodifiableListView(_serviceList);
  
  Service get currentService => _currentService;
  
  set serviceList(List<Service> servicelist){
    _serviceList = servicelist;
    notifyListeners();
  }

  set currentService(Service service){
    _currentService = service;
    notifyListeners();
  }
}