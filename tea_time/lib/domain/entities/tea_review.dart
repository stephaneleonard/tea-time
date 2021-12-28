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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['origin'] = this.origin;
    data['seconds'] = this.seconds;
    data['temp'] = this.temp;
    data['type'] = this.type;

    return data;
  }

  @override
  List<Object?> get props => <Object?>[name, origin, seconds, temp, type];
}
