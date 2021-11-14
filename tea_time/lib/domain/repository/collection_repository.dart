import 'package:tea_time/domain/entities/collection.dart';

abstract class CollectionRepository {
  Future<Collection> fetchCollection(String id);
  Future<void> addAContainer(String uid);
}
