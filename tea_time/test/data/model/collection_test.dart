import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tea_time/data/model/collection_model.dart';
import 'package:tea_time/data/model/tea_container_model.dart';
import 'package:tea_time/domain/entities/collection.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const CollectionModel collectionModel = CollectionModel(
    containers: <TeaContainer>[],
    name: 'name',
    owner: 'owner',
    id: 'id',
  );
  const CollectionModel collectionModelWithContainer = CollectionModel(
    name: 'name',
    containers: <TeaContainer>[
      TeaContainerModel(
        name: 'name',
        type: 'green',
        reviewId: 'reviewId',
        filled: true,
      ),
      TeaContainerModel(
        name: 'name',
        type: 'green',
        reviewId: 'reviewId',
        filled: true,
      ),
      TeaContainerModel(
        filled: false,
      ),
      TeaContainerModel(
        filled: false,
      ),
      TeaContainerModel(
        filled: false,
      )
    ],
    owner: 'owner',
    id: 'id',
  );

  test(
    'User Model should extend User',
    () async {
      // assert
      expect(collectionModel, isA<Collection>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when the JSON with a empty list',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('collection_with empty_containers.json'))
                as Map<String, dynamic>;
        // act
        final CollectionModel result = CollectionModel.fromJson(jsonMap, 'id');
        // assert
        expect(result, collectionModel);
      },
    );
    test(
      'should return a valid model when the JSON with a filled list',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('collection_with_containers.json'))
                as Map<String, dynamic>;
        // act
        final CollectionModel result = CollectionModel.fromJson(jsonMap, 'id');
        // assert
        expect(result, collectionModelWithContainer);
      },
    );
  });
}
