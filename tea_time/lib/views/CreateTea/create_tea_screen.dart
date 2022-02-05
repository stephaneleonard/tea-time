import 'package:flutter/material.dart';
import 'package:tea_time/domain/entities/tea_container.dart';
import 'package:tea_time/views/CreateTea/create_tea_form.dart';
import 'package:tea_time/widgets/custom_app_bar.dart';

class CreateTeaScreen extends StatelessWidget {
  const CreateTeaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
    final String uid = args!.first as String;
    final List<TeaContainer>? containerList = args[1] as List<TeaContainer>?;
    final int position = args[2] as int;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Tea Time'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: CreateteaForm(
            uid: uid,
            containerList: containerList,
            position: position,
          ),
        ),
      ),
    );
  }
}
