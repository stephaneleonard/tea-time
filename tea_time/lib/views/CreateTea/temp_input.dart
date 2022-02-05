import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:tea_time/widgets/icon_and_int.dart';

class TempInput extends StatelessWidget {
  const TempInput({
    required this.temp,
    required this.func,
    Key? key,
  }) : super(key: key);

  final int temp;

  final void Function(int) func;

  @override
  Widget build(BuildContext context) {
    void _onConfirm(Picker picker, List<int> value) {
      // You get your duration here
      func(picker.getSelectedValues().first as int);
    }

    void _onTap() {
      Picker(
        adapter: NumberPickerAdapter(
          data: <NumberPickerColumn>[
            NumberPickerColumn(
              begin: 65,
              initValue: temp,
              end: 100,
              jump: 5,
            ),
          ],
        ),
        hideHeader: true,
        confirmText: 'Select',
        cancelText: 'cancel',
        cancelTextStyle: TextStyle(
          inherit: false,
          color: Colors.grey.shade400,
          fontSize: 16,
        ),
        confirmTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.green,
        ),
        title: const Text('Select temps'),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: _onConfirm,
      ).showDialog(context);
    }

    return GestureDetector(
      onTap: _onTap,
      child: IconAndInt(
        icon: Icons.thermostat,
        value: '$temp °C',
        color: Colors.green,
      ),
    );
  }
}
