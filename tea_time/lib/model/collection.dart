import 'package:cloud_firestore/cloud_firestore.dart';

class Collection {
  Collection({required this.owner, required this.containers});

  Collection.fromFirebase(DocumentSnapshot<Map<String, dynamic>?> data) {
    owner = data.data()!['owner'].toString();
    data.data()!['containers'].forEach(
      (dynamic mapValue) {
        containers.add(
          TeaContainer.fromFirebase(
            Map<String, dynamic>.from(mapValue),
          ),
        );
      },
    );
  }

  late String owner;
  List<TeaContainer> containers = <TeaContainer>[];
}

class TeaContainer {
  TeaContainer(
      {required this.name, required this.type, required this.reviewId});

  TeaContainer.fromFirebase(Map<String, dynamic> data) {
    name = data['name'] as String?;
    type = data['type'] as String?;
    reviewId = data['reviewId'] as String?;
  }

  late String? name;
  late String? type;
  late String? reviewId;
}

Future<Collection> fetchCollection(String id) async {
  CollectionReference<Object?> collections =
      FirebaseFirestore.instance.collection('Collection');
  DocumentSnapshot<Map<String, dynamic>?> data = await collections.doc(id).get()
      as DocumentSnapshot<Map<String, dynamic>?>;
  return Collection.fromFirebase(data);
}
