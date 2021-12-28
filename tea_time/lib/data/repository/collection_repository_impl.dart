import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/data/model/collection_model.dart';
import 'package:tea_time/domain/entities/collection.dart';
import 'package:tea_time/domain/repository/collection_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionReference<Object?> collections =
      FirebaseFirestore.instance.collection('Collection');
  @override
  Future<Collection> fetchCollection(String id) async {
    final DocumentSnapshot<Map<String, dynamic>?> data = await collections
        .doc(id)
        .get() as DocumentSnapshot<Map<String, dynamic>?>;

    return CollectionModel.fromJson(data.data() ?? <String, dynamic>{}, id);
  }

  @override
  Future<void> addAContainer(String uid) async {
    await collections.doc(uid).update(<String, dynamic>{
      'containers': FieldValue.arrayUnion(
        <Map<String, dynamic>>[
          <String, dynamic>{'filled': false},
        ],
      ),
    });
  }

  @override
  Future<String> createCollection(String id, String name) async {
    final DocumentReference<Object?> _collection =
        await collections.add(<String, dynamic>{
      'name': name, // John Doe
      'owner': id, // Stokes and Sons
      'containers': <dynamic>[], // 42
    });

    return _collection.id;
  }
}
