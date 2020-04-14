import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 10,),
                Text('Waiting...'),
              ],
            ),
          ),
        ));
  }

  static void hidden(BuildContext context){
    Navigator.of(context).pop(LoadingDialog);
  }
}
