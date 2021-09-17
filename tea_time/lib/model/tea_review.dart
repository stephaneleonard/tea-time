import 'package:cloud_firestore/cloud_firestore.dart';

class TeaReview {
  TeaReview({
    required this.name,
    required this.origin,
    required this.type,
    required this.seconds,
    required this.temp,
  });

  TeaReview.fromFirebase(DocumentSnapshot<Map<String, dynamic>?> data) {
    name = data.data()!['name'] as String;
    origin = data.data()!['origin'] as String;
    type = data.data()!['type'] as String;
    seconds = data.data()!['seconds'] as int;
    temp = data.data()!['temp'] as int;
  }

  late String name;
  late String origin;
  late String type;
  int seconds = 0;
  int temp = 0;
}

Future<TeaReview> fetchTeaReview(String id) async {
  CollectionReference<Object?> teaReviews =
      FirebaseFirestore.instance.collection('TeaReview');
  DocumentSnapshot<Map<String, dynamic>?> data =
      await teaReviews.doc(id).get() as DocumentSnapshot<Map<String, dynamic>?>;
  return TeaReview.fromFirebase(data);
}
