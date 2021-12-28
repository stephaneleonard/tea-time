import 'package:flutter/material.dart';

class FormConfirmButton extends StatelessWidget {
  const FormConfirmButton({
    required this.isLoading,
    required this.create,
    Key? key,
  }) : super(key: key);

  final bool isLoading;

  final void Function() create;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(
            double.infinity,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: create,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text('Create'),
      ),
    );
  }
}
