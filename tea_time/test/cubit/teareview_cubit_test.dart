import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tea_time/cubit/teareview_cubit.dart';
import 'package:tea_time/data/model/tea_review_model.dart';
import 'package:tea_time/domain/entities/tea_review.dart';
import 'package:tea_time/domain/repository/tea_review_repository.dart';

const TeaReviewModel teaReview = TeaReviewModel(
  id: 'id',
  name: 'MANDALA',
  seconds: 225,
  temp: 85,
  type: 'green',
  origin: 'nepal',
);

class MockTeaReviewRepository implements TeaReviewrepository {
  @override
  Future<TeaReview> fetchTeaReview(String id) {
    if (id == 'id1') {
      throw 'error test';
    }

    return Future<TeaReview>.delayed(
      const Duration(milliseconds: 1),
      () => teaReview,
    );
  }
}

void main() {
  late TeaReviewCubit teaReviewCubit;
  MockTeaReviewRepository mockTeaReviewRepository;

  group('testing teaReview cubit', () {
    setUp(() {
      mockTeaReviewRepository = MockTeaReviewRepository();
      teaReviewCubit = TeaReviewCubit(mockTeaReviewRepository);
    });

    blocTest(
      'should return loading loaded',
      build: () => teaReviewCubit,
      act: (TeaReviewCubit cubit) => cubit.getTeaReviewById('id'),
      expect: () => <TeaReviewState>[
        const TeaReviewLoading(),
        const TeaReviewLoaded(teaReview),
      ],
    );

    blocTest(
      'should return loading error',
      build: () => teaReviewCubit,
      act: (TeaReviewCubit cubit) => cubit.getTeaReviewById('id1'),
      expect: () => <TeaReviewState>[
        const TeaReviewLoading(),
        const TeaReviewError('error test'),
      ],
    );

    tearDown(() {
      teaReviewCubit.close();
    });
  });
}
