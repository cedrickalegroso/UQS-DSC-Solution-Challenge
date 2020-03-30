import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:UQS/Models/user.dart';

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
    String photoUrl
  ) async {
    return await userCollection.document(uid).setData({
      'uid' : uid,
      'name': name,
      'phonenumber': phoneNumber,
      'email': email,
      'photoUrl': 'https://firebasestorage.googleapis.com/v0/b/theuqs-52673.appspot.com/o/default%2FppDef.png?alt=media&token=ee4c1229-d521-47a3-91f0-1c2cd70e2232',
    });
  }

//creating an instance of the class User(ara sa user.dart sa models na folder) para istore ang data halin sa database
  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: uid,
        email: snapshot.data['email'] ?? '',
        name: snapshot.data['name'] ?? '',
        phoneNumber: snapshot.data['phonenumber']  ?? '',
        photoUrl: snapshot.data['photoUrl']?? '');
  }

//listens to the stream para magkuha data kung kailangan
  Stream<User> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

//incase need ta ang list sang mga users nga naka register
  /* List<User> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
        uid: uid,
        email: doc.data['email'] ?? '',
        name: doc.data['name'] ?? '',
        phoneNumber: doc.data['phoneNumber'] ?? '',
      );
    }).toList();
  }

  Stream<List<User>> get user {
    return userCollection.snapshots().map(_userDataFromSnapshot);
  }*/
}
