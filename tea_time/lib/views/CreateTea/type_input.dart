import 'package:flutter/material.dart';

class TypeInput extends StatelessWidget {
  const TypeInput({
    required this.type,
    required this.func,
    Key? key,
  }) : super(key: key);

  final String type;

  final void Function(String) func;

  @override
  Widget build(BuildContext context) {
    void _onTap(String? s) {
      func(s ?? 'green');
    }

    return DropdownButton<String>(
      isExpanded: true,
      value: type,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      items: const <DropdownMenuItem<String>>[
        DropdownMenuItem<String>(
          value: 'green',
          child: Text('Green'),
        ),
        DropdownMenuItem<String>(
          value: 'black',
          child: Text('Black'),
        ),
        DropdownMenuItem<String>(
          value: 'oolong',
          child: Text('Oolong'),
        ),
        DropdownMenuItem<String>(
          value: 'puher',
          child: Text('Puher'),
        ),
        DropdownMenuItem<String>(
          value: 'white',
          child: Text('White'),
        ),
        DropdownMenuItem<String>(
          value: 'rooibos',
          child: Text('Rooibos'),
        ),
        DropdownMenuItem<String>(
          value: 'infusion',
          child: Text('Infusion'),
        ),
      ],
      onChanged: _onTap,
    );
  }
}
