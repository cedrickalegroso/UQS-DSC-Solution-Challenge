import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:UQS/Models/ticket.dart';
import 'package:http/http.dart' as http;

class TicketDatabase {
  final num ticketCount;
  final num isEmailNotify;
  final String ticketOwnerUid;
  final String uid;
  final String refNo;
  final String serviceUid;
  final String serviceAbbreviation;
  final bool emailNotify;
  final int trigger;
  final num alreadyNotified;
  TicketDatabase(
      {this.ticketCount,
      this.isEmailNotify,
      this.ticketOwnerUid,
      this.uid,
      this.refNo,
      this.serviceUid,
      this.serviceAbbreviation,
      this.emailNotify,
      this.trigger,
      this.alreadyNotified});

  final CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  final CollectionReference serviceCollection =
      Firestore.instance.collection('services');

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
        isEmailNotify: doc.data['isEmailNotify'] ?? 0,
        trigger: doc.data['trigger'] ?? 0,
        alreadyNotified: doc.data['alreadyNotified'] ?? 0,
      );
    }).toList();
  }

  Ticket _ticketDataFromSnapshot(DocumentSnapshot snapshot) {
    return Ticket(
      isEmailNotify: snapshot.data['isEmailNotify'] ?? 0,
      refNo: snapshot.data['refNo'],
      serviceUid: snapshot.data['serviceUid'] ?? '',
      teller: snapshot.data['teller'] ?? 0,
      ticketNo: snapshot.data['ticketNo'] ?? '',
      ticketOwnerUid: snapshot.data['ticketOwnerUid'] ?? '',
      ticketRaw: snapshot.data['ticketRaw'] ?? 0,
      trigger: snapshot.data['trigger'] ?? '',
      ticketStatus: snapshot.data['ticketStatus'] ?? 0,
      timestamp: snapshot.data['timestamp'] ?? 0,
      alreadyNotified: snapshot.data['alreadyNotified'] ?? 0,
    );
  }

  List<Done> _doneTicketListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Done(
        refNo: doc.data['refNo'] ?? '',
        serviceUid: doc.data['serviceUid'] ?? '',
        teller: doc.data['teller'] ?? 0,
        ticketNo: doc.data['ticketNo'] ?? 0,
        ticketOwnerUid: doc.data['ticketOwnerUid'] ?? '',
        ticketRaw: doc.data['ticketRaw'] ?? 0,
        ticketStatus: doc.data['ticketStatus'] ?? 0,
        timestamp: doc.data['timestamp'] ?? 0,
        isEmailNotify: doc.data['isEmailNotify'] ?? 0,
        trigger: doc.data['trigger'] ?? 0,
        alreadyNotified: doc.data['alreadyNotified'] ?? 0,
      );
    }).toList();
  }

  List<Cancelled> _cancelledTicketListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Cancelled(
        refNo: doc.data['refNo'] ?? '',
        serviceUid: doc.data['serviceUid'] ?? '',
        teller: doc.data['teller'] ?? 0,
        ticketNo: doc.data['ticketNo'] ?? 0,
        ticketOwnerUid: doc.data['ticketOwnerUid'] ?? '',
        ticketRaw: doc.data['ticketRaw'] ?? 0,
        ticketStatus: doc.data['ticketStatus'] ?? 0,
        timestamp: doc.data['timestamp'] ?? 0,
        isEmailNotify: doc.data['isEmailNotify'] ?? 0,
        trigger: doc.data['trigger'] ?? 0,
        alreadyNotified: doc.data['alreadyNotified'] ?? 0,
      );
    }).toList();
  }

  //get stream from the database (returns a list of active tickets)
  Stream<List<Ticket>> get activeTickets {
    return ticketCollection
        .where('ticketOwnerUid', isEqualTo: ticketOwnerUid)
        .where('ticketStatus', isGreaterThan: 0)
        .where('ticketStatus', isLessThanOrEqualTo: 2)
        // .orderBy('timestamp', descending: false)//basehan ya ang timestamp kung ano ang order sang list sng active tickets
        .snapshots()
        .map(_activeTicketListFromSnapshot);
  }

  Stream<List<Done>> get doneTickets {
    return ticketCollection
        .where('ticketOwnerUid', isEqualTo: ticketOwnerUid)
        .where('ticketStatus', isEqualTo: 3)
        // .orderBy('timestamp', descending: false)//basehan ya ang timestamp kung ano ang order sang list sng active tickets
        .snapshots()
        .map(_doneTicketListFromSnapshot);
  }

  Stream<List<Cancelled>> get cancelled {
    return ticketCollection
        .where('ticketOwnerUid', isEqualTo: ticketOwnerUid)
        .where('ticketStatus', isEqualTo: 0)
        // .orderBy('timestamp', descending: false)//basehan ya ang timestamp kung ano ang order sang list sng active tickets
        .snapshots()
        .map(_cancelledTicketListFromSnapshot);
  }

  //get stream from the database (returns specific data of a ticket)
  Stream<Ticket> get ticketData {
    return ticketCollection
        .document(refNo)
        .snapshots()
        .map(_ticketDataFromSnapshot);
  }

  Future initNotify(refNo) async {
    ticketCollection.document(refNo).updateData({'alreadyNotified': 1});
    return notifyUser(refNo);
  }

  Future<http.Response> notifyUser(refNo) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    print('notify triggered ' + refNo);

    Response response = await post(
      'https://us-central1-theuqs-52673.cloudfunctions.net/app/api/NotifyUser:uid:refNo',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'uid': user.uid,
        'refNo': refNo,
      }),
    );

    print(response.statusCode);
    print(response.body);
    return response;
  }

  //function to generate ticket using api
  Future initTicket() async {
    print('========= CREATE TICKET ======');
    print('sid' + serviceUid);
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();

    var checkQuery = ticketCollection
        .where('serviceUid', isEqualTo: serviceUid)
        .where('ticketOwnerUid', isEqualTo: user.uid)
        .where('ticketStatus', isEqualTo: 1);
    var querySnapthot = await checkQuery.getDocuments();
    var totalEquals = querySnapthot.documents.length;
    var zero = 0;

    totalEquals == zero ? createTicket() : print('nope');
  }

  Future createTicket() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    var unixTimestamp = DateTime.now().millisecondsSinceEpoch;
    var ticketNo = ticketCount + 1;
    var refNo =
        serviceAbbreviation + ticketNo.toString() + unixTimestamp.toString();

    ticketCollection.document(refNo).setData({
      'refNo': refNo,
      'serviceUid': serviceUid,
      'ticketNo': serviceAbbreviation + ticketNo.toString(),
      'ticketRaw': ticketNo,
      'ticketOwnerUid': user.uid,
      'timestamp': unixTimestamp,
      'teller': 0,
      'ticketStatus': 1,
      'alreadyNotified': 0,
      'trigger': trigger,
      'isEmailNotify': emailNotify == true ? 1 : 0
    });

    /*  ticketCollection.document(refNo).collection('timeline').document(unixTimestamp.toString()).setData({
           'message': '$unixTimestamp Ticket Created'
      }); */

    serviceCollection
        .document(serviceUid)
        .updateData({'ticketCount': ticketNo});
  }



  //function to read ticket timeline from server
  Future<http.Response> readTimeline() async {
   


    Response response = await post(
      'https://us-central1-theuqs-52673.cloudfunctions.net/app/api/CancelTicket:refNo',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'refNo': refNo,
      }),
    );

    print(response.statusCode);
    print(response.body);
    return response;
  }

  //function to generate ticket using api
  Future<http.Response> cancelTicket() async {


    Response response = await post(
      'https://us-central1-theuqs-52673.cloudfunctions.net/app/api/CancelTicket:refNo',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'refNo': refNo,
      }),
    );

    print(response.statusCode);
    print(response.body);
    return response;
  }
}
