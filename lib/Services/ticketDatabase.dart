import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:uqsbeta/Models/ticket.dart';
import 'package:http/http.dart' as http;

class TicketDatabase {
  final String ticketOwnerUid;
  final String refNo;
  final String serviceUid;
  final String serviceAbbreviation;
  TicketDatabase(
      {this.ticketOwnerUid,
      this.refNo,
      this.serviceUid,
      this.serviceAbbreviation});

  final CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  List<Ticket> _activeTicketListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Ticket(
        refNo: doc.data['refNo'] ?? '',
        serviceUid: doc.data['serviceUid'] ?? '',
        teller: doc.data['teller'] ?? 0,
        ticketNo: doc.data['ticketNo'] ?? 0,
        ticketOwnerUid: doc.data['ticketOwnerUid'] ?? '',
        ticketRaw: doc.data['ticketRaw'] ?? 0,
        ticketStatus: doc.data['ticketStatus'] ?? 0,
        timestamp: doc.data['timestamp'] ?? 0,
      );
    }).toList();
  }

  Ticket _ticketDataFromSnapshot(DocumentSnapshot snapshot) {
    return Ticket(
      refNo: snapshot.data['refNo'],
      serviceUid: snapshot.data['serviceUid'],
      teller: snapshot.data['teller'],
      ticketNo: snapshot.data['ticketNo'],
      ticketOwnerUid: snapshot.data['ticketOwnerUid'],
      ticketRaw: snapshot.data['ticketRaw'],
      ticketStatus: snapshot.data['ticketStatus'],
      timestamp: snapshot.data['timestamp'],
    );
  }

  //get stream from the database (returns a list of active tickets)
  Stream<List<Ticket>> get activeTickets {
    return ticketCollection
        .where('ticketOwnerUid', isEqualTo: ticketOwnerUid)
       // .orderBy('timestamp', descending: false)//basehan ya ang timestamp kung ano ang order sang list sng active tickets
        .snapshots()
        .map(_activeTicketListFromSnapshot);
  }

  //get stream from the database (returns specific data of a ticket)
  Stream<Ticket> get ticketData {
    return ticketCollection
        .document(refNo)
        .snapshots()
        .map(_ticketDataFromSnapshot);
  }

  //function to generate ticket using api
  Future<http.Response> addTicket() async {
    print('addticket');
    print('sid' + serviceUid);
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Response response = await post(
      'https://us-central1-theuqs-52673.cloudfunctions.net/app/api/creaticketNew:sid:uid:abb',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'sid': serviceUid,
        'uid': user.uid,
        'abb': serviceAbbreviation
      }),
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }
  //function to generate ticket using firestore
  // Future<void> addTicket() async {
  //   int unixTimestamp = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   FirebaseUser user = await _auth.currentUser();

  //   ticketCollection
  //       .orderBy('ticketRaw', descending: true)
  //       .where('serviceUid', isEqualTo: serviceUid)
  //       .limit(1)
  //       .getDocuments()
  //       .then((snapshot) async {
  //     if (snapshot == null) {
  //       return await ticketCollection.document('${1 + unixTimestamp}').setData({
  //         'refNo': serviceAbbreviation + 1.toString() + unixTimestamp.toString(),
  //         'serviceUid': serviceUid,
  //         'ticketNo': serviceAbbreviation + 1.toString(),
  //         'ticketRaw': 1.toString(),
  //         'ticketOwnerUid': user.uid,
  //         'timestamp': (DateTime.now().millisecondsSinceEpoch / 1000).floor()
  //       });
  //     } else {
  //       snapshot.documents.forEach((doc) async {
  //         int ticketRaw1 = doc.data['ticketRaw'] + 1;
  //         String _refNo = serviceAbbreviation + ticketRaw1.toString() + unixTimestamp.toString();
  //         String ticketFinal = serviceAbbreviation + ticketRaw1.toString();

  //         return await ticketCollection.document('$_refNo').setData({
  //           'refNo': _refNo,
  //           'serviceUid': serviceUid,
  //           'ticketNo': ticketFinal,
  //           'ticketRaw': ticketRaw1,
  //           'ticketOwnerUid': user.uid,
  //           'timestamp': (DateTime.now().millisecondsSinceEpoch / 1000).floor()
  //         });
  //       });
  //     }
  //   });
  // }
}
