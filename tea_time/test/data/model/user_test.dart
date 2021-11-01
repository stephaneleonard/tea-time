import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tea_time/data/model/user.dart';
import 'package:tea_time/domain/entities/user.dart';

import '../../fixtures/fixture_reader.dart';

main() {
  const tUserModel =
      UserModel(collectionId: 'collection', name: 'Stéphane', id: 'id');
  const tUserModelNull =
      UserModel(collectionId: null, name: 'Stéphane', id: 'id');

  test(
    'User Model should extend User',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when the JSON with a collection',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('user_with_collection.json'));
        // act
        final result = UserModel.fromJson(jsonMap, 'id');
        // assert
        expect(result, tUserModel);
      },
    );
    test(
      'should return a valid model when the JSON is without a collection',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('user_without_collection.json'));
        // act
        final result = UserModel.fromJson(jsonMap, 'id');
        // assert
        expect(result, tUserModelNull);
      },
    );
  });
}
