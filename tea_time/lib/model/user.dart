import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/utils/auth.dart';

class User {
  User({required this.id, required this.name, required this.collectionId});

  User.fromFirebase(QuerySnapshot<Map<String, dynamic>?> data) {
    name = data.docs[0].data()!['name'];
    collectionId = data.docs[0].data()!['collection'];
    id = data.docs[0].id;
  }

  late String id;
  late String name;
  String? collectionId;
}

Future<User> fetchUser() async {
  CollectionReference<Object?> users =
      FirebaseFirestore.instance.collection('User');
  QuerySnapshot<Map<String, dynamic>?> data = await users
      .where('UID', isEqualTo: firebaseAuth.currentUser!.uid)
      .get() as QuerySnapshot<Map<String, dynamic>?>;
  return User.fromFirebase(data);
}
