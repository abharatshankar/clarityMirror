import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAlertDialog {

  static alertDialogWidget({String? title, String? message, required VoidCallback onCompleted,required BuildContext context}) {
    return AlertDialog(
      title: Text(title ?? 'Alert Dialog'),
      content: Text(message ?? 'Are you sure to close the dialog'),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            onCompleted();
            // Navigator.of(AppNavigation.rootNavigatorKey.currentContext!).pop();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static showCustomDialog({required String? title, String? message,required BuildContext context}) async {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title ?? 'Alert Dialog'),
      content: Text(message ?? 'Are you sure to close the dialog'),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    return showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  static Future<void> showLoadingDialog( BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const SimpleDialog(
              // key: key,
              backgroundColor: Colors.black54,
              children: <Widget>[
                Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Loading....",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ]),
                ),
              ],
            ),
          );
        });
  }

  static stopLoadingIndicator( BuildContext context) {
    // AppNavigation.rootNavigatorKey.currentContext!.pop();
    Navigator.pop(context);
  }
}
