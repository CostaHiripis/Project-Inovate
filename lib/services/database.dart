import 'package:CheckOff/users/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

abstract class BaseAuth {
  Future<FirebaseUser> getCurrentUser();
}

class Authenticator implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
}

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference studentsCollection =
      Firestore.instance.collection('users');

  String taskName = "";
  final CollectionReference userAssignments =
      Firestore.instance.collection('userAssignments');

  Future<void> updateStudentData(
      String email, String userName, String password, int authority) async {
    return await studentsCollection.document(uid).setData({
      'email': email,
      'userName': userName,
      'password': password,
      'authority': authority,
      // 'timestamp': DateTime.now()
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        userName: snapshot.data['userName'],
        email: snapshot.data['email'],
        authority: snapshot.data['authority']);
  }

  // get users stream
  Stream<DocumentSnapshot> get users {
    // return studentsCollection.snapshots().map(studentsCollection);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return studentsCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  //Add an event
  Future<void> addEvent(String taskName, String userEmail, DateTime postDate,
      DateTime eventDay) async {
    return await userAssignments.document(uid).setData({
      'taskName': taskName,
      'userEmail': userEmail,
      'postDate': postDate,
      'eventDay': eventDay
    });
  }
  //Return current user email (Used for calendar page)
  Future<String> returnUserEmail() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return(user.email);
  }

  //Get current user Email
  Future<void> getLoggedUserEmail() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
  }
}

class DbSearch {
  String userPassword = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  final CollectionReference studentsCollection =
      Firestore.instance.collection('users');

  Future<void> getUserAccount(String email) async {
    // return await studentsCollection.document(uid).get().then((value) => null);

    //We reset field userPassword
    userPassword = "";

    //We look for user with email that was given in login form
    return studentsCollection
        .where("email", isEqualTo: email)
        .snapshots()
        .listen((data) =>
            data.documents.forEach((doc) => userPassword = doc["password"]));
  }
}
