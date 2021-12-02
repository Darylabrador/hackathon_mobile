import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Snackbar {
  static void showScaffold(
    String message,
    bool isSuccess,
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message),
        backgroundColor:
            isSuccess ? Colors.green : Theme.of(context).errorColor,
      ),
    );
  }
}
