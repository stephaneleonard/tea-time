import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:tea_time/views/BrewingScreen/brewing_screen.dart';

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
    return GestureDetector(
      onTap: () {
        Picker(
          adapter: NumberPickerAdapter(
            data: <NumberPickerColumn>[
              NumberPickerColumn(
                initValue: minutes,
                end: 15,
              ),
              NumberPickerColumn(
                initValue: seconds,
                end: 45,
                jump: 15,
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
          onConfirm: (Picker picker, List<int> value) {
            // You get your duration here
            func(
              picker.getSelectedValues()[0] as int,
              picker.getSelectedValues()[1] as int,
            );
          },
        ).showDialog(context);
      },
      child: IconAndInt(
        icon: Icons.hourglass_bottom,
        value: '$minutes : $seconds',
        color: Colors.green,
      ),
    );
  }
}
