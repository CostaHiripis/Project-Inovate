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
}
