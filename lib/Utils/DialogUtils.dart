import 'package:flutter/material.dart';

class DialogUtils {

  // Show loading dialog
  static void showLoading({required BuildContext context, required String message}) {

    showDialog(
      barrierDismissible: false,
      context:context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  // Hide loading dialog
  static void hideLoading({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  // Show message dialog
  static void showMessage({required BuildContext context,
    required String message,
    bool positiveAction = false,
    bool negativeAction = false,
    VoidCallback? onPositiveAction,
    VoidCallback? onNegativeAction,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(message),
          actions: [
            if (positiveAction)
              TextButton(
                onPressed: () {
                  if (onPositiveAction != null) {
                    onPositiveAction();
                  }

                },
                child: Text("OK"),
              ),
            if (negativeAction)
              TextButton(
                onPressed: () {
                  if (onNegativeAction != null) {
                    onNegativeAction();
                  }

                },
                child: Text("Close"),
              ),
          ],
        );
      },
    );
  }
}