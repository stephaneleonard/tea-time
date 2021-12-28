import 'package:equatable/equatable.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

class Collection extends Equatable {
  const Collection({
    required this.id,
    required this.owner,
    required this.containers,
    required this.name,
  }) : super();

  final String? owner;
  final String id;
  final String name;
  final List<TeaContainer>? containers;

  @override
  List<Object?> get props => <Object?>[owner, containers, id];
}
