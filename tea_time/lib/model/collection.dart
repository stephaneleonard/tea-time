import 'package:cloud_firestore/cloud_firestore.dart';

class Collection {
  Collection({required this.owner});

  Collection.fromFirebase(DocumentSnapshot<Map<String, dynamic>?> data) {
    owner = data.data()!['owner'].toString();
  }

  late String owner;
}

Future<Collection> fetchCollection(String id) async {
  CollectionReference<Object?> users =
      FirebaseFirestore.instance.collection('Collection');
  DocumentSnapshot<Map<String, dynamic>?> data =
      await users.doc(id).get() as DocumentSnapshot<Map<String, dynamic>?>;
  return Collection.fromFirebase(data);
}
