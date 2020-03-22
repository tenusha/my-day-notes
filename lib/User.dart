import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String password;
  DocumentReference reference;

  User({this.username, this.password});

  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    username = map["username"];
    password = map["password"];
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {'username': username, 'password': password};
  }
}
