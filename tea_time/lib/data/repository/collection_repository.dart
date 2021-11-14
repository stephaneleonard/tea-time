import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/data/model/collection.dart';
import 'package:tea_time/domain/entities/collection.dart';
import 'package:tea_time/domain/repository/collection_repository.dart';

class ICollectionRepository implements CollectionRepository {
  @override
  Future<Collection> fetchCollection(String id) async {
    final CollectionReference<Object?> collections =
        FirebaseFirestore.instance.collection('Collection');
    final DocumentSnapshot<Map<String, dynamic>?> data = await collections
        .doc(id)
        .get() as DocumentSnapshot<Map<String, dynamic>?>;
    return CollectionModel.fromJson(data.data() ?? <String, dynamic>{}, id);
  }

  @override
  Future<void> addAContainer(String uid) async {
    final CollectionReference<Object?> collections =
        FirebaseFirestore.instance.collection('Collection');
    await collections.doc(uid).update(<String, dynamic>{
      'containers': FieldValue.arrayUnion(<Map<String, dynamic>>[
        <String, dynamic>{'filled': false}
      ])
    });
  }
}
