import 'package:equatable/equatable.dart';

class TeaContainer extends Equatable {
  const TeaContainer({
    required this.name,
    required this.reviewId,
    required this.type,
    required this.filled,
  });
  final String? name;
  final String? type;
  final String? reviewId;
  final bool filled;
  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[name, type, reviewId, filled];
}
