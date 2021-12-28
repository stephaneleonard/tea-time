import 'package:tea_time/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String accountId,
    required String name,
    required String? collectionId,
  }) : super(
          name: name,
          accountId: accountId,
          collectionId: collectionId,
          id: id,
        );

  factory UserModel.fromJson(
    Map<String, dynamic> json,
    String id,
    String accountId,
  ) {
    return UserModel(
      id: id,
      accountId: accountId,
      name: json['name'] as String,
      collectionId: json['collection'] as String?,
    );
  }
}
