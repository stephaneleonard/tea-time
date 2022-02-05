import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/teareview_cubit.dart';
import 'package:tea_time/data/repository/tea_review_repository_impl.dart';
import 'package:tea_time/views/BrewingScreen/tea_info.dart';
import 'package:tea_time/widgets/custom_app_bar.dart';

class BrewingScreen extends StatelessWidget {
  const BrewingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Brewing',
      ),
      body: BlocProvider<TeaReviewCubit>(
        create: (BuildContext context) =>
            TeaReviewCubit(TeaReviewRepositoryImpl()),
        child: TeaInfo(
          reviewId: id,
        ),
      ),
    );
  }
}
