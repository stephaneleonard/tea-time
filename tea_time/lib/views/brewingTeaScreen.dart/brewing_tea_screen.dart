import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tea_time/cubit/tea_review_cubit.dart';
import 'package:tea_time/model/screen_arguments.dart';
import 'package:tea_time/model/tea_review.dart';
import 'package:tea_time/widgets/appbard.dart';

class BrewingScreen extends StatelessWidget {
  const BrewingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return BlocProvider<TeaReviewCubit>(
      create: (BuildContext context) => TeaReviewCubit(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Box: ${args.index + 1}'),
        body: TeaInfosList(id: args.id),
        bottomNavigationBar: const BottomAppBar(
          child: BottomTimerBar(),
        ),
      ),
    );
  }
}

class TeaInfosList extends StatelessWidget {
  const TeaInfosList({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    context.read<TeaReviewCubit>().getTeaReviewInfos(id);
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: BlocBuilder<TeaReviewCubit, TeaReviewState>(
          builder: (BuildContext context, TeaReviewState state) {
        if (state is TeaReviewLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TeaReviewLoaded) {
          return TeaInfos(teaReview: state.teaReview);
        }
        if (state is TeaReviewError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: Text('Unexpected error'),
        );
      }),
    );
  }
}

class TeaInfos extends StatelessWidget {
  const TeaInfos({required this.teaReview, Key? key}) : super(key: key);

  final TeaReview teaReview;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Center(
            child: Text(
              teaReview.name,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          TimeAndTemp(
            time: teaReview.seconds,
            temp: teaReview.temp,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Center(
            child: Image.asset(
              'assets/images/${teaReview.type}.png',
              height: 222,
            ),
          )
        ],
      ),
    );
  }
}

class TimeAndTemp extends StatelessWidget {
  const TimeAndTemp({required this.time, required this.temp, Key? key})
      : super(key: key);

  final int time;
  final int temp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              'assets/svg/hourglass.svg',
              width: 20,
            ),
            Text(
              '${(time / 60).floor()}:${time % 60}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              'assets/svg/thermometer.svg',
              width: 20,
            ),
            Text(
              '$temp°C',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        )
      ],
    );
  }
}

class BottomTimerBar extends StatelessWidget {
  const BottomTimerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeaReviewCubit, TeaReviewState>(
        builder: (BuildContext context, TeaReviewState state) {
      if (state is TeaReviewLoading) {
        return const CircularProgressIndicator();
      }
      if (state is TeaReviewLoaded) {
        return TimerRow(time: state.teaReview.seconds);
      }
      if (state is TeaReviewError) {
        return Text(state.message);
      }
      return const Text('unexpected error');
    });
  }
}

class TimerRow extends StatefulWidget {
  const TimerRow({required this.time, Key? key}) : super(key: key);

  String convertSecondsToMinutes(int seconds) {
    return '''${(seconds / 60).floor().toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}''';
  }

  final int time;

  @override
  _TimerRowState createState() => _TimerRowState();
}

class _TimerRowState extends State<TimerRow> {
  static int remainingTime = 0;
  Isolate? _isolate;
  ReceivePort? _receivePort;
  bool isOn = false;

  @override
  void initState() {
    remainingTime = widget.time;
    super.initState();
  }

  void _start() async {
    setState(() {
      isOn = true;
    });
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_checkTimer, _receivePort!.sendPort);
    _receivePort!.listen(_handleMessage, onDone: () {});
  }

  static void _checkTimer(SendPort sendPort) async {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (remainingTime == 1) {
        sendPort.send('finished');
      } else {
        sendPort.send('ok');
      }
    });
  }

  void _handleMessage(dynamic data) {
    if (remainingTime > 0) {
      setState(() {
        remainingTime--;
      });
    } else {
      _stop();
    }
  }

  void _stop() {
    if (_isolate != null) {
      setState(() {
        isOn = false;
        remainingTime = widget.time;
      });
      _receivePort!.close();
      _isolate!.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.convertSecondsToMinutes(remainingTime),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  isOn ? Colors.red : Colors.green),
            ),
            onPressed: isOn
                ? () {
                    _stop();
                  }
                : () {
                    _start();
                  },
            child: Text(
              isOn ? 'Cancel' : 'Start',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
