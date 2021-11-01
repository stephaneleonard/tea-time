import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  const Collection({required this.id, required this.name, this.collectionId})
      : super();

  final String name;
  final String? collectionId;
  final String id;

  @override
  List<Object> get props => [name];
}
