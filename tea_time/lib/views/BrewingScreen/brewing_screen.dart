import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/teareview_cubit.dart';
import 'package:tea_time/data/repository/tea_review_repository.dart';
import 'package:tea_time/widgets/custom_app_bar.dart';

class BrewingScreen extends StatelessWidget {
  const BrewingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments! as String;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Brewing',
      ),
      body: BlocProvider<TeaReviewCubit>(
        create: (BuildContext context) =>
            TeaReviewCubit(ITeareviewRepository()),
        child: TeaInfos(
          reviewId: id,
        ),
      ),
    );
  }
}

class TeaInfos extends StatelessWidget {
  const TeaInfos({required this.reviewId, Key? key}) : super(key: key);

  final String reviewId;

  String convertTempToString(int temp) {
    return "$temp'";
  }

  String convertSecondsToString(int seconds) {
    final int min = seconds ~/ 60;
    final int sec = seconds % 60;
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    context.read<TeaReviewCubit>().getTeaReviewById(reviewId);
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
                      fontSize: 20,
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
                      ),
                      const Padding(padding: EdgeInsets.only(left: 40)),
                      IconAndInt(
                        icon: Icons.thermostat,
                        value: convertTempToString(state.teaReview.temp),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/${state.teaReview.type}.png',
                  height: 200,
                ),
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

class IconAndInt extends StatelessWidget {
  const IconAndInt({
    required this.value,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        const Padding(padding: EdgeInsets.only(left: 5)),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
