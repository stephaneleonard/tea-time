import 'package:flutter/material.dart';
import 'package:tea_time/views/CreateTea/temp_input.dart';
import 'package:tea_time/views/CreateTea/time_input.dart';

class TimeAndTempInputRow extends StatelessWidget {
  const TimeAndTempInputRow({
    required this.minutes,
    required this.seconds,
    required this.temp,
    required this.setTime,
    required this.setTemp,
    Key? key,
  }) : super(key: key);

  final int minutes;

  final int seconds;

  final int temp;

  final void Function(int, int) setTime;

  final void Function(int) setTemp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TimeInput(
            minutes: minutes,
            seconds: seconds,
            func: setTime,
          ),
          TempInput(
            temp: temp,
            func: setTemp,
          ),
        ],
      ),
    );
  }
}
