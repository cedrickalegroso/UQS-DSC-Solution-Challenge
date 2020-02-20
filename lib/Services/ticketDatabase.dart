import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uqsbeta/Models/ticket.dart';

class TicketDatabase {
  final String ticketOwnerUid;
  final String refNo;
  TicketDatabase({this.ticketOwnerUid, this.refNo});

  final CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  List<Ticket> _activeTicketListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Ticket(
        refNo: doc.data['refNo'] ?? '',
        serviceUid: doc.data['serviceUid'] ?? '',
        ticketNo: doc.data['ticketNo'] ?? '',
        ticketOwnerUid: doc.data['ticketOwnerUid'] ?? '',
        timestamp: doc.data['timestamp'] ?? '',
      );
    }).toList();
  }

  Ticket _ticketDataFromSnapshot(DocumentSnapshot snapshot) {
    return Ticket(
      refNo: snapshot.data['refNo'],
      serviceUid: snapshot.data['serviceUid'],
      ticketNo: snapshot.data['ticketNo'],
      ticketOwnerUid: snapshot.data['ticketOwnerUid'],
      timestamp: snapshot.data['timestamp'],
    );
  }

  //get service stream from the database (returns a list of services)
  Stream<List<Ticket>> get activeTickets {
    return ticketCollection
        .where('ticketOwnerUid', isEqualTo: ticketOwnerUid)
        .snapshots()
        .map(_activeTicketListFromSnapshot);
  }

  //get serviceData stream from the database (returns specific data of a service)
  Stream<Ticket> get ticketData {
    return ticketCollection
        .document(refNo)
        .snapshots()
        .map(_ticketDataFromSnapshot);
  }
}
