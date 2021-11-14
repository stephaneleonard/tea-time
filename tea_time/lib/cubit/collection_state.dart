part of 'collection_cubit.dart';

@immutable
abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object?> get props => <Object?>[];
}

class CollectionInitial extends CollectionState {
  const CollectionInitial();

  @override
  List<Object?> get props => <Object?>[];
}

class CollectionLoading extends CollectionState {
  const CollectionLoading();

  @override
  List<Object?> get props => <Object?>[];
}

class CollectionLoaded extends CollectionState {
  const CollectionLoaded(this.collection);
  final Collection collection;

  @override
  List<Object?> get props => <Object?>[collection];
}

class CollectionError extends CollectionState {
  const CollectionError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
