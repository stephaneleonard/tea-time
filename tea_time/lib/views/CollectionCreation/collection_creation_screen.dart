import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/data/repository/collection_repository_impl.dart';
import 'package:tea_time/data/repository/user_repository_impl.dart';
import 'package:tea_time/widgets/custom_app_bar.dart';
import 'package:tea_time/widgets/custom_input_field.dart';

class CollectionCreationScreen extends StatefulWidget {
  const CollectionCreationScreen({Key? key}) : super(key: key);

  @override
  State<CollectionCreationScreen> createState() =>
      _CollectionCreationScreenState();
}

class _CollectionCreationScreenState extends State<CollectionCreationScreen> {
  final TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final String id =
        // ignore: cast_nullable_to_non_nullable
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Tea Time'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                  children: const <Widget>[
                    Text(
                      'Create Collection',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                CustomInputField(
                  controller: _name,
                  hint: 'Name of the collection',
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      final String uid = await CollectionRepositoryImpl()
                          .createCollection(id, _name.text);
                      await UserRepositoryImpl().addCollection(id, uid);
                      if (!mounted) return;
                      await context.read<UserCubit>().getUserInfos();
                      if (!mounted) return;
                      Navigator.pop(context);
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Create'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
