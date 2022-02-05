import 'package:equatable/equatable.dart';

class TeaReview extends Equatable {
  const TeaReview({
    required this.id,
    required this.name,
    required this.origin,
    required this.seconds,
    required this.temp,
    required this.type,
    required this.notes,
  });
  final String id;
  final String name;
  final String? origin;
  final int seconds;
  final int temp;
  final String type;
  final String? notes;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['origin'] = origin;
    data['seconds'] = seconds;
    data['temp'] = temp;
    data['type'] = type;
    data['notes'] = notes;

    return data;
  }

  @override
  List<Object?> get props =>
      <Object?>[name, origin, seconds, temp, type, notes];
}
