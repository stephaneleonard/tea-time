import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tea_time/data/model/tea_review.dart';
import 'package:tea_time/domain/entities/tea_review.dart';

import '../../fixtures/fixture_reader.dart';

const TeaReviewModel teaReviewModel = TeaReviewModel(
  id: 'id',
  name: 'MANDALA',
  seconds: 225,
  temp: 85,
  type: 'green',
  origin: 'nepal',
);
void main() {
  test(
    'User Model should extend User',
    () async {
      // assert
      expect(teaReviewModel, isA<TeaReview>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('tea_review.json')) as Map<String, dynamic>;
        // act
        final TeaReviewModel result = TeaReviewModel.fromJson(jsonMap, 'id');
        // assert
        expect(result, teaReviewModel);
      },
    );
  });
}
