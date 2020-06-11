import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference studentsCollection =
      Firestore.instance.collection('users');

  Future<void> updateStudentData(
      String email, String userName, String password, int authority) async {
    return await studentsCollection.document(uid).setData({
      'email': email,
      'userName': userName,
      'password': password,
      'authority': authority
    });
  }

  Future<void> getUserAccount(String email, String password) async {
    // return await studentsCollection.document(uid).get().then((value) => null);
    return await studentsCollection
        .where("email", isEqualTo: email)
        .snapshots()
        .listen(
            (data) => data.documents.forEach((doc) => print(doc["password"])));
  }
}

class DbSearch {
  String userPassword = "";
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
