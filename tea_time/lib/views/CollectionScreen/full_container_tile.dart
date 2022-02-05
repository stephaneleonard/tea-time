import 'package:flutter/material.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

class FullContainerTile extends StatelessWidget {
  const FullContainerTile({
    required this.index,
    required this.container,
    Key? key,
  }) : super(key: key);

  final TeaContainer container;
  final int index;

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      // ignore: avoid_print
      Navigator.pushNamed(
        context,
        '/brewing',
        arguments: container.reviewId ?? '',
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
                child: Image.asset(
                  'assets/images/${container.type}.png',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 5,
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
              container.name ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
