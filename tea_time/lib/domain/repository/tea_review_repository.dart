import 'package:tea_time/domain/entities/tea_review.dart';

abstract class TeaReviewrepository {
  Future<TeaReview> fetchTeaReview(String id);
}
