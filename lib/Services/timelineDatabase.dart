import 'package:UQS/Models/timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimelineDatabase {
  final String uid;
  final String refNo;
  final String message;

  TimelineDatabase({this.message, this.uid, this.refNo});

  final CollectionReference serviceCollection =
      Firestore.instance.collection('tickets');
 
     Timeline _timeLineDataFromSnapshot(DocumentSnapshot snapshot) {
    return Timeline(
      message: snapshot.data['message'],
    );
  }
  Stream<Timeline> get serviceData {
    return serviceCollection
        .document(uid)
        .snapshots()
        .map(_timeLineDataFromSnapshot);
  }

}