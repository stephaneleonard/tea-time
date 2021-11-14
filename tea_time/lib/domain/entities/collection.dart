import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  const Collection({
    required this.filled,
    this.id,
    this.name,
    this.collectionId,
  }) : super();

  final String? name;
  final bool filled;
  final String? collectionId;
  final String? id;

  @override
  List<Object?> get props => <Object?>[filled, name, collectionId, id];
}
