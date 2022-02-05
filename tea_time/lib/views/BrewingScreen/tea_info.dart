import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/teareview_cubit.dart';
import 'package:tea_time/widgets/icon_and_int.dart';

class TeaInfo extends StatelessWidget {
  const TeaInfo({required this.reviewId, Key? key}) : super(key: key);

  final String reviewId;

  String convertTempToString(int temp) {
    return '$temp°C';
  }

  String convertSecondsToString(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secondes = seconds % 60;

    return """${minutes.toString().padLeft(2, "0")}:${secondes.toString().padLeft(2, "0")}'""";
  }

  @override
  Widget build(BuildContext context) {
    context.read<TeaReviewCubit>().getTeaReviewById(reviewId);
    const double _imageHeight = 200;

    return BlocBuilder<TeaReviewCubit, TeaReviewState>(
      builder: (BuildContext context, TeaReviewState state) {
        if (state is TeaReviewLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TeaReviewLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    state.teaReview.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconAndInt(
                        icon: Icons.hourglass_bottom,
                        value: convertSecondsToString(state.teaReview.seconds),
                        color: Colors.green,
                      ),
                      const Padding(padding: EdgeInsets.only(left: 40)),
                      IconAndInt(
                        icon: Icons.thermostat,
                        value: convertTempToString(state.teaReview.temp),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/${state.teaReview.type}.png',
                  height: _imageHeight,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'origin',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(state.teaReview.origin ?? ''),
                const Text('notes'),
                Text(state.teaReview.notes ?? ''),
              ],
            ),
          );
        }
        if (state is TeaReviewError) {
          return Center(
            child: Text(state.message),
          );
        }

        return const Center(
          child: Text('error'),
        );
      },
    );
  }
}
