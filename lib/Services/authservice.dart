import 'package:firebase_auth/firebase_auth.dart';
import 'package:UQS/Services/userDatabase.dart';
import 'package:UQS/Models/user.dart';


//@cedrick gin compile ko na di tanan nga function concerning Firebase Authentication
class AuthService {
  //creating an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creating ang instance of the class User(see user.dart under models) based on a user from the database
  User _userFromFireBaseUser(FirebaseUser user) {
    //if the FireBaseUser user parameter is not null, then assign the uid of that user to _userFromFireBaseUser
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            photoUrl: user.photoUrl,
            phoneNumber: user.phoneNumber,
            name: user.displayName
          )
        : null;
  }

  //set up a stream to listen for changes in authstate i.e. if user logged in or a user has logged out
  Stream<User> get authState {
    //map out the stream and get the properties of the user from the database and passes it to the user object
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }

  //function for signing in using email and password
  Future<User> signInEmail(String email, String password) async {
    try {
      //calling the built in sign func of FirebaseAuth using email and password as parameters
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

        if (user.isEmailVerified) {
        return _userFromFireBaseUser(user);
      } else {
        return null;
        }
      //the user property of result is then passed to _userFromFireBaseUser as its parameter
     // 
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //log out func
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
  Future<User> signUp(
      String email, String password, String name, String phoneNumber) async {
    try {
      // try to create the user
      AuthResult credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = credentials.user;

      user.sendEmailVerification(); // sends email verification
      //updateProfile(user); => previous func used
      //create an instance of the class DatabaseService using the uid as a parameter,
      //then use the function under this class to update userdata
      await DatabaseService(uid: user.uid)
          .updateUserData(name, phoneNumber, user.email, '');
      return _userFromFireBaseUser(user);
    } catch (e) {
      // catch the error
      print(e.toString()); // print the error
      return null;
    }
  }

  Future<User> currentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return _userFromFireBaseUser(user);
  }
}