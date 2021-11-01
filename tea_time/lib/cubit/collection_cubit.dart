import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_time/data/model/collection.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(const CollectionInitial());

  Future<void> getCollection(String id) async {
    try {
      emit(const CollectionLoading());
      final Collection collection = await fetchCollection(id);
      emit(CollectionLoaded(collection));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }
}
