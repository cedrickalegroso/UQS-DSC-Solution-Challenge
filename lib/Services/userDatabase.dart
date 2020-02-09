import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uqsbeta/Models/user.dart';

//@cedrick ari naman d ya ang tanan nga function concerning the database for users.
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //create instance sa database collection ('userCollection') para butangan sang user data
  final CollectionReference userCollection =
      Firestore.instance.collection('userCollection');

  /*void updateProfile(user) {
    Firestore.instance.collection('users').add({
      // add the uid and the email in the firestore document ref
      'uid': user.uid,
      'email': user.email
    });
  } => previous function used */
  //func para magupdate sang user data sa database under userCollection
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

//creating an instance of the class UserData(ara sa user.dart sa models na folder) para istore ang data halin sa database
 UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        email: snapshot.data['email'],
        name: snapshot.data['name'],
        phoneNumber: snapshot.data['phonenumber'],
        photoUrl: snapshot.data['photoUrl']);
  }

//listens to the stream para magkuha data kung kailangan
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

//incase need ta ang list sang mga users nga naka register
  /* List<UserData> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        uid: uid,
        email: doc.data['email'] ?? '',
        name: doc.data['name'] ?? '',
        phoneNumber: doc.data['phoneNumber'] ?? '',
      );
    }).toList();
  }

  Stream<List<UserData>> get user {
    return userCollection.snapshots().map(_userDataFromSnapshot);
  }*/
}
