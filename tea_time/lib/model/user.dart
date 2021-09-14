import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/utils/auth.dart';

class User {
  const User({required this.name});

  final String name;
}

Future<User> fetchUser() async {
  CollectionReference<Object?> users =
      FirebaseFirestore.instance.collection('User');
  QuerySnapshot<Object?> data =
      await users.where('UID', isEqualTo: firebaseAuth.currentUser!.uid).get();
  return User(name: data.docs[0]['name']);
}
