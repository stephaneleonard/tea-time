import 'package:equatable/equatable.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

class Collection extends Equatable {
  const Collection({
    required this.id,
    required this.owner,
    required this.containers,
  }) : super();

  final String? owner;
  final String id;
  final List<TeaContainer>? containers;

  @override
  List<Object?> get props => <Object?>[owner, containers, id];
}
