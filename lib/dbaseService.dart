import 'models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//bali ari d tanan nga function concerning the database.
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
//create instance sa database collection ('userCollection') para butangan sang user data
  final CollectionReference userCollection =
      Firestore.instance.collection('userCollection');
//func para magupdate sang user data database under userCollection
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

//creating an instance of the class UserData(ara sa models na folder) para istore ang data halin sa database
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      email: snapshot.data['email'],
      name: snapshot.data['name'],
      phoneNumber: snapshot.data['phonenumber'],
    );
  }

//listens to the stream para magkuha data kung kailangan
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
