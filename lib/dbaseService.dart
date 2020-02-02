import 'models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('userCollection');

  Future<void> updateUserData(
    String name,
    String phoneNumber,
    String email,
  ) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'phonenumber': phoneNumber,
      'email': email,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      email: snapshot.data['email'],
      name: snapshot.data['name'],
      phoneNumber: snapshot.data['phonenumber'],
    );
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
