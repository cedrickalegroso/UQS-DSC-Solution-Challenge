import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uqsbeta/Models/service.dart';

//functions for concerning the database for services
class ServiceDatabase {
  final String uid;

  ServiceDatabase({this.uid});

  //create an instance basi sa collection na 'services' halin sa database
  final CollectionReference serviceCollection =
      Firestore.instance.collection('services');

  //create a list of instances of class Service(see service.dart under Models)
  //This returns snapshots of data under the documents included in the collection
  //and assigns these values to the instances in the list
  List<Service> _serviceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Service(
        uid: uid,
        email: doc.data['email'] ?? '',
        displayName: doc.data['displayName'] ?? '',
        phoneNumber: doc.data['phoneNumber'] ?? '',
        photoUrl: doc.data['photoUrl'] ?? '',
      );
    }).toList();
  }

  //get service stream from the database
  Stream<List<Service>> get service {
    return serviceCollection.snapshots().map(_serviceListFromSnapshot);
  }
}
