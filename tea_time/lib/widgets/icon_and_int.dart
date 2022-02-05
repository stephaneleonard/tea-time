import 'package:flutter/material.dart';

class IconAndInt extends StatelessWidget {
  const IconAndInt({
    required this.value,
    required this.icon,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        const Padding(padding: EdgeInsets.only(left: 5)),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
