import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/core/theming/auth/auth.dart';
import 'package:tea_time/data/model/user.dart';
import 'package:tea_time/domain/entities/user.dart';
import 'package:tea_time/domain/repository/user_repository.dart';

class IUserRepository implements UserRepository {
  @override
  Future<User> fetchUser() async {
    final String id = firebaseAuth.currentUser!.uid;
    final CollectionReference<Object?> users =
        FirebaseFirestore.instance.collection('User');
    final QuerySnapshot<Map<String, dynamic>?> data = await users
        .where('UID', isEqualTo: id)
        .get() as QuerySnapshot<Map<String, dynamic>?>;
    if (data.docs.isEmpty) {
      throw Exception('No user with that id');
    }
    return UserModel.fromJson(data.docs[0].data() ?? <String, dynamic>{}, id);
  }

  @override
  Future<void> createUser(String uid, String name) async {
    final CollectionReference<Object?> users =
        FirebaseFirestore.instance.collection('User');
    await users.add(<String, dynamic>{
      'UID': uid,
      'name': name,
    });
  }
}
