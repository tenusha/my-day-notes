import '../model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getUsers(String collectionName) {
  return Firestore.instance.collection(collectionName).snapshots();
}

getUser(String collectionName, String username) {
  return Firestore.instance
      .collection(collectionName)
      .where('username', isEqualTo: username)
      .getDocuments()
      .then((QuerySnapshot docs) {
    print('getUser()');
    if (docs.documents.isEmpty) {
      print('No existing user');
      return null;
    } else {
      print('existing user found');
      return docs.documents[0];
    }
  });
}

addUser(String collectionName, User user) async {
  bool status = false;

  try {
    status = await Firestore.instance
        .collection(collectionName)
        .where('username', isEqualTo: user.username)
        .getDocuments()
        .then((QuerySnapshot docs) {
      print('addUser()');
      if (docs.documents.isEmpty) {
        print('No existing user');
        Firestore.instance.runTransaction((Transaction transaction) async {
          await Firestore.instance
              .collection(collectionName)
              .document()
              .setData(user.toJson());
        });
        return true;
      } else {
        print('existing user found');
        return false;
      }
    });
  } catch (e) {
    print(e.toString());
  }
  return status;
}

updateUser(User user, String newName) {
  try {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.update(user.reference, {'username': newName});
    });
  } catch (e) {
    print(e.toString());
  }
}

deleteUser(User user) {
  Firestore.instance.runTransaction((Transaction transaction) async {
    await transaction.delete(user.reference);
  });
}
