import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.accountId,
    required this.name,
    this.collectionId,
  }) : super();

  final String name;
  final String accountId;
  final String? collectionId;
  final String id;

  @override
  List<Object?> get props => <Object?>[name, collectionId, id];
}
