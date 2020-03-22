import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String password;
  DocumentReference reference;

  User({this.name});

  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    name = map["name"];
    password = map["password"];
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {'name': name, 'password': password};
  }
}
