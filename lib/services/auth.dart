import 'package:CheckOff/users/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:CheckOff/services/database.dart';
import 'package:random_string/random_string.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, email: user.email, userName: user.displayName)
        : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return 'chuujjjfiwaojnfoiawnoifawnhoiufbnhawuibfas';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

      // await DatabaseService(uid: user.uid).getUserAccount(email, password);
    } catch (err) {}
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email, String username, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateStudentData(email, username, password, 1);

      return _userFromFirebaseUser(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// create and event
  Future createAnEvent(
      String taskName, DateTime postDate, DateTime eventDate) async {
    try {
      String rndString = randomString(10);
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      await DatabaseService(uid: rndString)
          .addEvent(taskName, user.email, postDate, eventDate);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future<FirebaseUser> handleSignInEmail(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    // loggedUser = currentUser;
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return user;
  }
}

// class Auth {
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   Future<FirebaseUser> handleSignInEmail(String email, String password) async {
//     AuthResult result =
//         await auth.signInWithEmailAndPassword(email: email, password: password);
//     final FirebaseUser user = result.user;

//     assert(user != null);
//     assert(await user.getIdToken() != null);

//     final FirebaseUser currentUser = await auth.currentUser();
//     // loggedUser = currentUser;
//     assert(user.uid == currentUser.uid);

//     print('signInEmail succeeded: $user');

//     return user;
//   }
// }
