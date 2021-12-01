import 'package:flutter/material.dart';

class DoubleButtonForm extends StatelessWidget {
  final Function()? cancelHanlder;
  final Function()? validHandler;
  final String cancelText;
  final String validText;

  const DoubleButtonForm({
    required this.cancelHanlder,
    required this.cancelText,
    required this.validHandler,
    required this.validText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: ElevatedButton(
            child: Text(cancelText),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blueGrey,
              ),
            ),
            onPressed: cancelHanlder,
          ),
        ),
        const SizedBox(width: 15),
        SizedBox(
          width: 120,
          child: ElevatedButton(
            child: Text(validText),
            onPressed: validHandler,
          ),
        ),
      ],
    );
  }
}
