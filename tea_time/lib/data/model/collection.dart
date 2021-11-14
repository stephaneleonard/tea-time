import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_time/data/model/tea_container.dart';
import 'package:tea_time/domain/entities/collection.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

class CollectionModel extends Collection {
  const CollectionModel({
    required List<TeaContainer> containers,
    required String id,
    required String? owner,
  }) : super(containers: containers, id: id, owner: owner);

  factory CollectionModel.fromJson(Map<String, dynamic> json, String id) {
    final List<TeaContainer> containerList = <TeaContainer>[];
    json['containers'].forEach(
      (dynamic mapValue) {
        containerList.add(
          TeaContainerModel.fromJson(
            Map<String, dynamic>.from(mapValue as Map<String, dynamic>),
          ),
        );
      },
    );
    return CollectionModel(
      containers: containerList,
      id: id,
      owner: json['owner'].toString(),
    );
  }
}

Future<void> addContainer(String uid) async {
  final CollectionReference<Object?> collections =
      FirebaseFirestore.instance.collection('Collection');
  await collections.doc(uid).update(<String, dynamic>{
    'containers': FieldValue.arrayUnion(<Map<String, dynamic>>[
      <String, dynamic>{'filled': false}
    ])
  });
}
