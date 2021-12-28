import 'package:flutter/material.dart';
import 'package:tea_time/data/repository/tea_review_repository_impl.dart';
import 'package:tea_time/domain/entities/tea_review.dart';
import 'package:tea_time/views/CreateTea/form_confirm_button.dart';
import 'package:tea_time/views/CreateTea/temp_input.dart';
import 'package:tea_time/views/CreateTea/time_input.dart';
import 'package:tea_time/views/CreateTea/type_input.dart';
import 'package:tea_time/views/LoginScreen/login_screen.dart';
import 'package:tea_time/widgets/custom_app_bar.dart';

class CreateTeaScreen extends StatelessWidget {
  const CreateTeaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Tea Time'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: CreateteaForm(),
        ),
      ),
    );
  }
}

class CreateteaForm extends StatefulWidget {
  const CreateteaForm({Key? key}) : super(key: key);

  @override
  _CreateteaFormState createState() => _CreateteaFormState();
}

class _CreateteaFormState extends State<CreateteaForm> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _origin = TextEditingController();
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
        try {
          TeaReviewRepositoryImpl().createTeaReview(
            TeaReview(
              id: 'id',
              name: _name.text,
              origin: _origin.text,
              seconds: _seconds,
              temp: _temp,
              type: _type,
            ),
          );
          Navigator.pop(context);
        } catch (e) {
          setState(() {
            isLoading = false;
          });
        }
      });
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
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              return null;
            },
          ),
          TypeInput(type: _type, func: setType),
          FormConfirmButton(
            isLoading: isLoading,
            create: validateAndCreate,
          ),
        ],
      ),
    );
  }
}

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
