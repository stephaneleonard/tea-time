import 'package:tea_time/domain/entities/tea_review.dart';

class TeaReviewModel extends TeaReview {
  const TeaReviewModel({
    required String id,
    required String name,
    required int seconds,
    required int temp,
    required String type,
    String? notes,
    String? origin,
  }) : super(
          id: id,
          name: name,
          origin: origin,
          seconds: seconds,
          temp: temp,
          type: type,
          notes: notes,
        );

  factory TeaReviewModel.fromJson(Map<String, dynamic> json, String id) {
    return TeaReviewModel(
      id: id,
      name: json['name'] as String,
      seconds: json['seconds'] as int,
      temp: json['temp'] as int,
      type: json['type'] as String,
      origin: json['origin'] as String?,
      notes: json['notes'] as String?,
    );
  }
}
