import 'package:flutter/material.dart';
import 'package:tea_time/widgets/custom_app_bar.dart';

class CollectionCreationScreen extends StatelessWidget {
  const CollectionCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tea Time'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
