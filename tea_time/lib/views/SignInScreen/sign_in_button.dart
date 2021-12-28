import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({required this.isLoading, required this.func, Key? key})
      : super(key: key);

  final bool isLoading;

  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
        onPressed: func,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text('login'),
      ),
    );
  }
}
