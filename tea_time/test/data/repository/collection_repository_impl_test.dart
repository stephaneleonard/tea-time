import 'package:flutter_test/flutter_test.dart';
import 'package:tea_time/data/repository/collection_repository_impl.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

void main() {
  group('testing updating list', () {
    const TeaContainer _container = TeaContainer(
      name: 'test',
      reviewId: 'I6oNF303K4lh34RQFSdX',
      type: 'oolong',
      filled: true,
    );
    test('testing updating empty list', () {
      final List<Map<String, dynamic>> result = updateList(
        0,
        <Map<String, dynamic>>[],
        _container,
      );
      expect(
        <Map<String, dynamic>>[
          <String, dynamic>{
            'name': 'test',
            'reviewId': 'I6oNF303K4lh34RQFSdX',
            'type': 'oolong',
            'filled': true,
          },
        ],
        result,
      );
    });
    test('testing updating non filled index', () {
      final List<Map<String, dynamic>> result = updateList(
        1,
        <Map<String, dynamic>>[
          <String, dynamic>{
            'filled': false,
          },
          <String, dynamic>{
            'filled': false,
          },
          <String, dynamic>{
            'filled': false,
          },
        ],
        _container,
      );
      expect(
        <Map<String, dynamic>>[
          <String, dynamic>{
            'filled': false,
          },
          <String, dynamic>{
            'name': 'test',
            'reviewId': 'I6oNF303K4lh34RQFSdX',
            'type': 'oolong',
            'filled': true,
          },
          <String, dynamic>{
            'filled': false,
          },
        ],
        result,
      );
    });
    test('testing updating filled index', () {
      final List<Map<String, dynamic>> result = updateList(
        1,
        <Map<String, dynamic>>[
          <String, dynamic>{
            'filled': false,
          },
          <String, dynamic>{
            'name': 'test',
            'reviewId': 'I6oNF303K4lh34RQFSdX',
            'type': 'oolong',
            'filled': true,
          },
          <String, dynamic>{
            'filled': false,
          },
        ],
        const TeaContainer(
          name: 'test2',
          reviewId: 'I6oNF303K4lh34RQFSdX',
          type: 'green',
          filled: true,
        ),
      );
      expect(
        <Map<String, dynamic>>[
          <String, dynamic>{
            'filled': false,
          },
          <String, dynamic>{
            'name': 'test2',
            'reviewId': 'I6oNF303K4lh34RQFSdX',
            'type': 'green',
            'filled': true,
          },
          <String, dynamic>{
            'filled': false,
          },
        ],
        result,
      );
    });
  });
}
