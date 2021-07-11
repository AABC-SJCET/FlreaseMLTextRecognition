import 'package:flutter/material.dart';

loading(BuildContext context, {title = "Getting"}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
            title: Text(title),
            content: Text('Please wait...'),
          ));
}

popUpwithButton(BuildContext context, {required String title, required body}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
            title: Text('$title'),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$body"),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ));
}
