import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class Database {
  // static String userUid = 'cYTCNMtQzEcvBSD5wlVPbuVjmMf2';
  static String userUid = '';

  static Future<void> addItem({
    required String uUidPrefs,
    required String title,
    required String description,
  }) async {
    // print('cYTCNMtQzEcvBSD5wlVPbuVjmMf2');
    print('uUidPrefs: ' + uUidPrefs);
    DocumentReference documentReferencer = _mainCollection
        // .doc('cYTCNMtQzEcvBSD5wlVPbuVjmMf2')
        .doc(uUidPrefs)
        .collection('items')
        .doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String uUidPrefs,
    required String title,
    required String description,
    required String docId,
  }) async {
    print('uUidPrefs: ' + uUidPrefs);
    DocumentReference documentReferencer =
        _mainCollection.doc(uUidPrefs).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems(getuUidPrefs) {
    print('uUidPrefs: ' + getuUidPrefs);
    CollectionReference notesItemCollection =
        _mainCollection.doc('cYTCNMtQzEcvBSD5wlVPbuVjmMf2').collection('items');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String uUidPrefs,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(uUidPrefs).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
