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
        abbreviation: doc.data['abbreviation'] ?? '',
        address: doc.data['address'] ?? '',
        displayName: doc.data['displayName'] ?? '',
        email: doc.data['email'] ?? '',
        phoneNumber: doc.data['phoneNumber'] ?? '',
        photoUrl: doc.data['photoUrl'] ?? '',
        uid: doc.data['uid'] ?? '',
      );
    }).toList();
  }

  //creating an instance of the class Service(ara sa models na folder) para istore ang data halin sa database
  Service _serviceDataFromSnapshot(DocumentSnapshot snapshot) {
    return Service(
      abbreviation: snapshot.data['abbreviation'],
      address: snapshot.data['address'],
      displayName: snapshot.data['displayName'] ?? '',
      email: snapshot.data['email'] ?? '',
      phoneNumber: snapshot.data['phoneNumber'] ?? '',
      photoUrl: snapshot.data['photoUrl'] ?? '',
      uid: snapshot.data['uid'] ?? '',
    );
  }

  //get service stream from the database (returns a list of services)
  Stream<List<Service>> get service {
    return serviceCollection.snapshots().map(_serviceListFromSnapshot);
  }

  //get serviceData stream from the database (returns specific data of a service)
  Stream<Service> get serviceData {
    return serviceCollection
        .document(uid)
        .snapshots()
        .map(_serviceDataFromSnapshot);
  }
}
