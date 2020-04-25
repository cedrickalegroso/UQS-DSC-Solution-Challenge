
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:UQS/Models/notification.dart';


class NotificationDatabase {
  final String message;
  final String notifOwnerUid;
  final String notifService;
  final num timestamp;

  NotificationDatabase(
      {this.message,
      this.notifOwnerUid,
      this.notifService,
      this.timestamp});

  final CollectionReference notificationCollection =
      Firestore.instance.collection('notifications');


  List<Notif> _notificationListFromSnapshot(QuerySnapshot snapshot) {
      return snapshot.documents.map((doc) {
       return Notif(
         message: doc.data['message'] ?? '',
         notifOwnerUid: doc.data['notifOwnerUid'] ?? '',
         timestamp: doc.data['timestamp'] ?? ''
       );
      }).toList();
    }

   Notif _notificationDataFromSnapshot(DocumentSnapshot snapshot) {
      return Notif(
        message: snapshot.data['message'],
        notifOwnerUid: snapshot.data['notifOwnerUid'],
        timestamp: snapshot.data['timestamp']
      );
    }

    Stream<List<Notif>> get notification {
      return notificationCollection
      .where('notifOwnerUid', isEqualTo: notifOwnerUid)
      .snapshots()
      .map(_notificationListFromSnapshot);
    }

  //get stream from the database (returns specific data of a ticket)
  Stream<Notif> get notifData {
    return notificationCollection
        .document(notifOwnerUid)
        .snapshots()
        .map(_notificationDataFromSnapshot);
  }


}
