import 'package:flutter/material.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

class EmptyContainerTile extends StatelessWidget {
  const EmptyContainerTile({
    required this.index,
    required this.collectionId,
    required this.containerList,
    Key? key,
  }) : super(key: key);

  final int index;

  final String collectionId;

  final List<TeaContainer>? containerList;

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      Navigator.pushNamed(
        context,
        '/create_tea',
        arguments: <dynamic>[
          collectionId,
          containerList,
          index,
        ],
      );
    }

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade200
              : Colors.grey.shade800,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Icon(
                  Icons.edit,
                  size: 50,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
            ),
            Text(
              'Box: ${index + 1}',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 7,
              ),
            ),
            Text(
              'Empty',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
