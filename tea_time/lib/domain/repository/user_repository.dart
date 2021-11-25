import 'package:tea_time/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> fetchUser();
  Future<void> createUser(String uid, String name);
}
