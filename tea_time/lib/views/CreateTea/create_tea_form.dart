import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/data/repository/collection_repository_impl.dart';
import 'package:tea_time/data/repository/tea_review_repository_impl.dart';
import 'package:tea_time/domain/entities/tea_container.dart';
import 'package:tea_time/domain/entities/tea_review.dart';
import 'package:tea_time/views/CreateTea/form_confirm_button.dart';
import 'package:tea_time/views/CreateTea/time_and_temp_input_row.dart';
import 'package:tea_time/views/CreateTea/type_input.dart';
import 'package:tea_time/widgets/custom_input_field.dart';

class CreateteaForm extends StatefulWidget {
  const CreateteaForm({
    required this.uid,
    required this.containerList,
    required this.position,
    Key? key,
  }) : super(key: key);

  final String uid;

  final List<TeaContainer>? containerList;

  final int position;

  @override
  _CreateteaFormState createState() => _CreateteaFormState();
}

class _CreateteaFormState extends State<CreateteaForm> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _origin = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _minutes = 1;
  int _seconds = 0;
  int _temp = 65;
  String _type = 'green';
  bool isLoading = false;

  void setTime(int minutes, int seconds) {
    setState(() {
      _minutes = minutes;
      _seconds = seconds;
    });
  }

  void setTemp(int temp) {
    setState(() {
      _temp = temp;
    });
  }

  void setType(String type) {
    setState(() {
      _type = type;
    });
  }

  Future<void> validateAndCreate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final String uid = await TeaReviewRepositoryImpl().createTeaReview(
          TeaReview(
            id: 'id',
            name: _name.text,
            origin: _origin.text,
            seconds: _seconds + _minutes * 60,
            temp: _temp,
            type: _type,
            notes: _notes.text,
          ),
        );
        CollectionRepositoryImpl().updateContainerList(
          widget.position,
          widget.uid,
          widget.containerList!
              .map((TeaContainer container) => container.toJson())
              .toList(),
          TeaContainer(
            name: _name.text,
            type: _type,
            reviewId: uid,
            filled: true,
          ),
        );
        if (mounted) {
          context.read<CollectionCubit>().getCollection(widget.uid);
          Navigator.pop(context);
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: Text(
              'Tea Creation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          CustomInputField(
            controller: _name,
            hint: 'Name',
            capitalization: TextCapitalization.sentences,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              return null;
            },
          ),
          TimeAndTempInputRow(
            minutes: _minutes,
            seconds: _seconds,
            temp: _temp,
            setTime: setTime,
            setTemp: setTemp,
          ),
          CustomInputField(
            controller: _origin,
            hint: 'Origin',
            capitalization: TextCapitalization.sentences,
            validator: (String? value) {
              return null;
            },
          ),
          TypeInput(type: _type, func: setType),
          CustomInputField(
            controller: _notes,
            hint: 'Notes',
            capitalization: TextCapitalization.sentences,
            maxLines: 10,
            validator: (String? value) {
              return null;
            },
          ),
          FormConfirmButton(
            isLoading: isLoading,
            create: validateAndCreate,
          ),
        ],
      ),
    );
  }
}
