import 'package:tea_time/data/model/tea_container_model.dart';
import 'package:tea_time/domain/entities/collection.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

class CollectionModel extends Collection {
  const CollectionModel({
    required List<TeaContainer> containers,
    required String id,
    required String? owner,
    required String name,
  }) : super(containers: containers, name: name, id: id, owner: owner);

  factory CollectionModel.fromJson(Map<String, dynamic> json, String id) {
    final List<TeaContainer> containerList = <TeaContainer>[];

    for (final Map<String, dynamic> container in json['containers']) {
      containerList.add(
        TeaContainerModel.fromJson(
          Map<String, dynamic>.from(container),
        ),
      );
    }

    return CollectionModel(
      containers: containerList,
      id: id,
      name: json['name'].toString(),
      owner: json['owner'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (containers != null) {
      final List<TeaContainer> nncontainers = containers ?? <TeaContainer>[];
      data['containers'] = nncontainers
          .map((TeaContainer container) => container.toJson())
          .toList();
    }

    return data;
  }
}
