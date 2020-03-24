import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String displayName;
  String username;
  int password;
  DocumentReference reference;

  User({this.username, this.password, this.displayName});

  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    displayName = map["displayName"];
    username = map["username"];
    password = map["password"];
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {
      'username': username,
      'displayName': displayName,
      'password': password
    };
  }
}
