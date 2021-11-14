import 'package:equatable/equatable.dart';

class TeaReview extends Equatable {
  const TeaReview({
    required this.id,
    required this.name,
    required this.origin,
    required this.seconds,
    required this.temp,
    required this.type,
  });
  final String id;
  final String name;
  final String? origin;
  final int seconds;
  final int temp;
  final String type;

  @override
  List<Object?> get props => <Object?>[name, origin, seconds, temp, type];
}
