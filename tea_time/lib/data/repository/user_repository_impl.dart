import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/core/theming/auth/auth.dart';
import 'package:tea_time/data/model/user_model.dart';
import 'package:tea_time/domain/entities/user.dart';
import 'package:tea_time/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final CollectionReference<Object?> users =
      FirebaseFirestore.instance.collection('User');
  @override
  Future<User> fetchUser() async {
    final String id = firebaseAuth.currentUser?.uid ?? '';
    final QuerySnapshot<Map<String, dynamic>?> data = await users
        .where('UID', isEqualTo: id)
        .get() as QuerySnapshot<Map<String, dynamic>?>;
    if (data.docs.isEmpty) {
      throw Exception('No user with that id');
    }

    return UserModel.fromJson(
      data.docs.first.data() ?? <String, dynamic>{},
      id,
      data.docs.first.id,
    );
  }

  @override
  Future<void> createUser(String uid, String name) async {
    await users.add(<String, dynamic>{
      'UID': uid,
      'name': name,
    });
  }

  @override
  Future<void> addCollection(String id, String uid) async {
    await users.doc(id).update(<String, String>{'collection': uid});
  }
}
