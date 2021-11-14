import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tea_time/domain/entities/collection.dart';
import 'package:tea_time/domain/repository/collection_repository.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit(this.collectionRepository) : super(const CollectionInitial());

  final CollectionRepository collectionRepository;

  Future<void> getCollection(String id) async {
    try {
      emit(const CollectionLoading());
      final Collection collection =
          await collectionRepository.fetchCollection(id);
      emit(CollectionLoaded(collection));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }
}
