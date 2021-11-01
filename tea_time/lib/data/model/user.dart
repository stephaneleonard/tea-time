import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/core/theming/auth/auth.dart';
import 'package:tea_time/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required String id, required String name, required String? collectionId})
      : super(name: name, collectionId: collectionId, id: id);

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'],
      collectionId: json['collection'],
    );
  }
}

Future<User> fetchUser() async {
  String? id = firebaseAuth.currentUser!.uid;
  CollectionReference<Object?> users =
      FirebaseFirestore.instance.collection('User');
  QuerySnapshot<Map<String, dynamic>?> data = await users
      .where('UID', isEqualTo: id)
      .get() as QuerySnapshot<Map<String, dynamic>?>;
  if (data.docs.isEmpty) {
    throw Exception(['No user with that id']);
  }
  return UserModel.fromJson(data.docs[0].data() ?? {}, id);
}
