import 'package:tea_time/domain/entities/tea_container.dart';

class TeaContainerModel extends TeaContainer {
  const TeaContainerModel({
    required bool filled,
    String? name,
    String? type,
    String? reviewId,
  }) : super(filled: filled, name: name, type: type, reviewId: reviewId);

  factory TeaContainerModel.fromJson(Map<String, dynamic> data) {
    return TeaContainerModel(
      filled: data['filled'] as bool,
      name: data['name'] as String?,
      type: data['type'] as String?,
      reviewId: data['reviewId'] as String?,
    );
  }
}
