import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/domain/entities/collection.dart';
import 'package:tea_time/domain/entities/tea_container.dart';
import 'package:tea_time/domain/repository/collection_repository.dart';

const Collection collection =
    Collection(id: 'id', owner: 'owner', containers: <TeaContainer>[]);

class MockCollectionRepository implements CollectionRepository {
  @override
  Future<void> addAContainer(String uid) async {}

  @override
  Future<Collection> fetchCollection(String id) async {
    if (id == 'id1') {
      throw 'error test';
    }
    return Future<Collection>.delayed(
      const Duration(milliseconds: 1),
      () => collection,
    );
  }
}

void main() {
  late CollectionCubit collectionCubit;
  MockCollectionRepository mockCollectionRepository;

  group('testing collection cubit', () {
    setUp(() {
      mockCollectionRepository = MockCollectionRepository();
      collectionCubit = CollectionCubit(mockCollectionRepository);
    });

    blocTest(
      'should return loading loaded',
      build: () => collectionCubit,
      act: (CollectionCubit cubit) => cubit.getCollection('id'),
      expect: () => <CollectionState>[
        const CollectionLoading(),
        const CollectionLoaded(collection)
      ],
    );

    blocTest(
      'should return loading error',
      build: () => collectionCubit,
      act: (CollectionCubit cubit) => cubit.getCollection('id1'),
      expect: () => <CollectionState>[
        const CollectionLoading(),
        const CollectionError('error test')
      ],
    );

    tearDown(() {
      collectionCubit.close();
    });
  });
}
