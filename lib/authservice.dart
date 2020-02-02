import 'package:firebase_auth/firebase_auth.dart';
import 'package:uqsbeta/dbaseService.dart';
import 'package:uqsbeta/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user object based on a user from the database
  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //set up a stream to listen for changes in authstate i.e. if user logged in or a user has logged out
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(
        _userFromFireBaseUser); //map out the stream and get the properties of the user from the database and passes it to the user object
  }

  //sign in with email and password
  Future signInEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print(result);
      print(user);
      return _userFromFireBaseUser(
          user); //calls the user object based from the firebase then return the uid of the user
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //log out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//@cedrick gin modify ko lang imo gin ubra na sign up func hehe
  //sign up
  // called by on press submit
  Future signUp(String email,String password, String name, String phoneNumber) async {
    try {
      // try to create the user
      AuthResult credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = credentials.user;
      await DatabaseService(uid: user.uid)
          .updateUserData(name, phoneNumber, user.email);
      //updateProfile(user);// call the Update profile so we can inject the data on database
      return _userFromFireBaseUser(user);
    } catch (e) {
      // catch the error
      print(e); // print the error
    }
  }

  /*void updateProfile(user) {
    Firestore.instance.collection('users').add({
      // add the uid and the email in the firestore document ref
      'uid': user.uid,
      'email': user.email
    });
  }*/ 
}
