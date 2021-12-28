import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/domain/entities/user.dart';
import 'package:tea_time/domain/repository/user_repository.dart';

const User user = User(id: 'id', accountId: '', name: 'name');

class MockuserRepository implements UserRepository {
  @override
  Future<User> fetchUser() {
    return Future<User>.delayed(const Duration(milliseconds: 2), () => user);
  }

  @override
  Future<void> createUser(String uid, String name) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<void> addCollection(String uid, String id) {
    // TODO: implement addCollection
    throw UnimplementedError();
  }
}

void main() {
  late UserCubit userCubit;
  MockuserRepository mockuserRepository;

  group('testing user cubit', () {
    setUp(() {
      mockuserRepository = MockuserRepository();
      userCubit = UserCubit(mockuserRepository);
    });

    blocTest(
      'should return loading loaded',
      build: () => userCubit,
      act: (UserCubit cubit) => cubit.getUserInfos(),
      expect: () => <UserState>[const UserLoading(), const UserLoaded(user)],
    );

    tearDown(() {
      userCubit.close();
    });
  });
}
