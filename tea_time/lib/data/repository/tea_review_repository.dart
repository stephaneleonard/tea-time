import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/data/model/tea_review.dart';
import 'package:tea_time/domain/entities/tea_review.dart';
import 'package:tea_time/domain/repository/tea_review_repository.dart';

class ITeareviewRepository implements TeaReviewrepository {
  @override
  Future<TeaReview> fetchTeaReview(String id) async {
    final CollectionReference<Object?> teaReviews =
        FirebaseFirestore.instance.collection('TeaReview');
    final DocumentSnapshot<Map<String, dynamic>?> data = await teaReviews
        .doc(id)
        .get() as DocumentSnapshot<Map<String, dynamic>?>;
    return TeaReviewModel.fromJson(data.data() ?? <String, dynamic>{}, id);
  }
}
