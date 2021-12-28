import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/data/model/tea_review_model.dart';
import 'package:tea_time/domain/entities/tea_review.dart';
import 'package:tea_time/domain/repository/tea_review_repository.dart';

class TeaReviewRepositoryImpl implements TeaReviewrepository {
  final CollectionReference<Object?> teaReviews =
      FirebaseFirestore.instance.collection('TeaReview');
  @override
  Future<TeaReview> fetchTeaReview(String id) async {
    final DocumentSnapshot<Map<String, dynamic>?> data = await teaReviews
        .doc(id)
        .get() as DocumentSnapshot<Map<String, dynamic>?>;

    return TeaReviewModel.fromJson(data.data() ?? <String, dynamic>{}, id);
  }

  Future<void> createTeaReview(TeaReview teaReview) async {
    // Create review
    final DocumentReference<Object?> _review = await teaReviews.add(
      teaReview.toJson(),
    );
    // add it to collection at right place
  }
}
