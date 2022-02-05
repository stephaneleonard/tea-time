import 'package:tea_time/domain/entities/collection.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

abstract class CollectionRepository {
  Future<Collection> fetchCollection(String id);
  Future<void> addAContainer(String uid);
  Future<void> updateContainerList(
    int position,
    String uid,
    List<Map<String, dynamic>> containerList,
    TeaContainer container,
  );
  Future<String> createCollection(String uid, String name);
}
