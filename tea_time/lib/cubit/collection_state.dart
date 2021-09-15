part of 'collection_cubit.dart';

@immutable
abstract class CollectionState {
  const CollectionState();
}

class CollectionInitial extends CollectionState {
  const CollectionInitial();
}

class CollectionLoading extends CollectionState {
  const CollectionLoading();
}

class CollectionLoaded extends CollectionState {
  const CollectionLoaded(this.collection);
  final Collection collection;

  @override
  // ignore: avoid_renaming_method_parameters
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is CollectionLoaded && o.collection == collection;
  }

  @override
  int get hashCode => collection.hashCode;
}

class CollectionError extends CollectionState {
  const CollectionError(this.message);
  final String message;
}
