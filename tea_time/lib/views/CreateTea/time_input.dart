import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:tea_time/widgets/icon_and_int.dart';

class TimeInput extends StatelessWidget {
  const TimeInput({
    required this.minutes,
    required this.seconds,
    required this.func,
    Key? key,
  }) : super(key: key);

  final int minutes;

  final int seconds;

  final void Function(int, int) func;

  @override
  Widget build(BuildContext context) {
    void _onConfirm(Picker picker, List<int> value) {
      // You get your duration here
      func(
        picker.getSelectedValues().first as int,
        picker.getSelectedValues()[1] as int,
      );
    }

    void _onTap() {
      Picker(
        adapter: NumberPickerAdapter(
          data: <NumberPickerColumn>[
            NumberPickerColumn(
              initValue: minutes,
              end: 15,
              onFormatValue: (int value) => value.toString().padLeft(2, '0'),
            ),
            NumberPickerColumn(
              initValue: seconds,
              end: 45,
              jump: 15,
              onFormatValue: (int value) => value.toString().padLeft(2, '0'),
            ),
          ],
        ),
        delimiter: <PickerDelimiter>[
          PickerDelimiter(
            child: Container(
              width: 20.0,
              alignment: Alignment.center,
              child: const Text(
                ':',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        hideHeader: true,
        textStyle: const TextStyle(color: Colors.grey, fontSize: 17),
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
        title: const Text('Select duration'),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: _onConfirm,
      ).showDialog(context);
    }

    return GestureDetector(
      onTap: _onTap,
      child: IconAndInt(
        icon: Icons.hourglass_bottom,
        value:
            """${minutes.toString().padLeft(2, "0")} : ${seconds.toString().padLeft(2, "0")}'""",
        color: Colors.green,
      ),
    );
  }
}
