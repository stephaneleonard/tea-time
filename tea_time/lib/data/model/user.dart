import 'package:tea_time/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String? collectionId,
  }) : super(name: name, collectionId: collectionId, id: id);

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'] as String,
      collectionId: json['collection'] as String?,
    );
  }
}
