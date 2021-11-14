import 'package:cloud_firestore/cloud_firestore.dart';

class Collection {
  Collection({required this.owner, required this.containers});

  Collection.fromJson(Map<String, dynamic> json) {
    owner = json['owner'].toString();
    json['containers'].forEach(
      (dynamic mapValue) {
        containers.add(
          TeaContainer.fromJson(
            Map<String, dynamic>.from(mapValue as Map<String, dynamic>),
          ),
        );
      },
    );
  }

  late String owner;
  List<TeaContainer> containers = <TeaContainer>[];
}

class TeaContainer {
  TeaContainer({
    required this.name,
    required this.type,
    required this.reviewId,
  });

  TeaContainer.fromJson(Map<String, dynamic> data) {
    name = data['name'] as String?;
    type = data['type'] as String?;
    reviewId = data['reviewId'] as String?;
  }

  late String? name;
  late String? type;
  late String? reviewId;
}

Future<Collection> fetchCollection(String id) async {
  final CollectionReference<Object?> collections =
      FirebaseFirestore.instance.collection('Collection');
  final DocumentSnapshot<Map<String, dynamic>?> data = await collections
      .doc(id)
      .get() as DocumentSnapshot<Map<String, dynamic>?>;
  return Collection.fromJson(data.data() ?? <String, dynamic>{});
}

Future<void> addABox(String uid) async {
  final CollectionReference<Object?> collections =
      FirebaseFirestore.instance.collection('Collection');
  await collections.doc(uid).update(<String, dynamic>{
    'containers': FieldValue.arrayUnion(<Map<String, dynamic>>[
      <String, dynamic>{'filled': false}
    ])
  });
}
