import 'package:my_day/model/Note.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

getNotes(String collectionName, String username) {
  return Firestore.instance
      .collection(collectionName)
      .where('username', isEqualTo: username)
      .orderBy('timestamp', descending: true)
      .snapshots();
}

addNote(String collectionName, Note note) async {
  try {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await Firestore.instance
          .collection(collectionName)
          .document()
          .setData(note.toJson());
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
  return true;
}

updateNote(Note note, var newNote) {
  try {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.update(note.reference, newNote);
    });
  } catch (e) {
    print(e.toString());
  }
}

deleteNote(Note note) {
  Firestore.instance.runTransaction((Transaction transaction) async {
    await transaction.delete(note.reference);
  });
}
