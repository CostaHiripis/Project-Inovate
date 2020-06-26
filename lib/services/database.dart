import 'package:CheckOff/users/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'auth.dart';
import 'package:quiver/collection.dart';

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

  // String taskName = "";

  // List<String> userEventDays = new List();
  // List<String> userEventTaskDescriptions = new List();
  static var mapOfUserEvents = new Multimap();

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

//Get current user Email
  Future<void> getLoggedUserEmail() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
  }

//Get all the events of the user
  Future<void> storeUserEventsInMap(String email) {
    //We look for user with email that was given in login form

    if (mapOfUserEvents.length == 0) {
      userAssignments
          .where("userEmail", isEqualTo: email)
          .snapshots()
          .listen((data) => data.documents.forEach((doc) {
                DateTime eventDay = doc["eventDay"].toDate();

                //We format date to string and we get only Year,Month and day
                var formater = new DateFormat('yyyy-MM-dd');
                String formatted = formater.format(eventDay);
                String taskName = doc["taskName"];
                int ck = 0;
                mapOfUserEvents.add(formatted, taskName);

                // userEventTaskDescriptions.add(taskName);
                // mapOfUserEvents
                //     .addAll({'EventDay': eventDay, 'TaskName': taskName});
              }));
    }
  }

  void printMap() {
    mapOfUserEvents.forEach((key, value) {
      // String stringKey = key.toString();

      print('$key : $value');
    });
  }
}

// class DbSearch {
//   String userPassword = "";
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   FirebaseUser user;

//   final CollectionReference studentsCollection =
//       Firestore.instance.collection('users');

//   Future<void> getUserAccount(String email) async {
//     // return await studentsCollection.document(uid).get().then((value) => null);

//     //We reset field userPassword
//     userPassword = "";

//     //We look for user with email that was given in login form
//     return studentsCollection
//         .where("email", isEqualTo: email)
//         .snapshots()
//         .listen((data) =>
//             data.documents.forEach((doc) => userPassword = doc["password"]));
//   }
// }
