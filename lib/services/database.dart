import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference studentsCollection =
      Firestore.instance.collection('students');

  Future updateStudentData(
      String email, String userName, String password) async {
    return await studentsCollection
        .document(uid)
        .setData({'email': email, 'userName': userName, 'password': password});
  }
}
