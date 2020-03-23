import 'package:my_day/model/Note.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

getNotes(String collectionName, String username) {
  return Firestore.instance
      .collection(collectionName)
      .where('username', isEqualTo: username)
      .getDocuments()
      .then((QuerySnapshot docs) {
    print('getNotes()');
    if (docs.documents.isEmpty) {
      print('No existing notes');
      return null;
    } else {
      print('existing notes found');
      return docs.documents;
    }
  });
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

update(Note note, Note newNote) {
  try {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.update(note.reference, newNote.toJson());
    });
  } catch (e) {
    print(e.toString());
  }
}

delete(Note note) {
  Firestore.instance.runTransaction((Transaction transaction) async {
    await transaction.delete(note.reference);
  });
}
