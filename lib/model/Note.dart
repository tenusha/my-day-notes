import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String subject;
  String note;
  String username;
  int timestamp;
  DocumentReference reference;

  Note({this.subject, this.note, this.username, this.timestamp});

  Note.fromMap(Map<String, dynamic> map, {this.reference}) {
    subject = map["subject"];
    note = map["note"];
    username = map["username"];
    timestamp = map["timestamp"];
  }

  Note.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {
      'subject': subject,
      'note': note,
      'username': username,
      'timestamp': timestamp
    };
  }
}
