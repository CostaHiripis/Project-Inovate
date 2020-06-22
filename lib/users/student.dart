class User {
  final String email;
  final String userName;
  // final String password;
  final String uid;

  User({this.uid, this.email, this.userName});
}

class UserData {
  final String email;
  final String userName;
  final String password;
  final int authority;
  final String uid;

  UserData(
      {this.uid, this.email, this.password, this.authority, this.userName});
}
