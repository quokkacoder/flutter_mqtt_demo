
import 'package:flutter/material.dart';
import 'create_room_alert.dart';

class MyAlertDialog {
  static void showDeleteTopic(BuildContext context, String nameRoom, Function function) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              title: Text(
                'Alert !',
                style: TextStyle(color: Colors.red),
              ),
              content: Text('Do you want to out $nameRoom ?'),
              actions: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('CANCEL'),
                  color: Colors.blue,
                ),
                RaisedButton(
                  onPressed: (){
                    function();
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                  color: Colors.red,
                ),
              ],
            ));
  }

  static void showDisconnect(BuildContext context, Function function) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          title: Text(
            'Alert !',
            style: TextStyle(color: Colors.red),
          ),
          content: Text('Do you want to disconnect MQTT ?'),
          actions: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCEL'),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: (){
                function();
                Navigator.pop(context);
              },
              child: Text('OK'),
              color: Colors.red,
            ),
          ],
        ));
  }

  static void showCreateTopic(BuildContext context,) {
    showDialog(
        context: context,
        builder: (context) => CreateRoomWidget()
    );
  }

  static void showAlertOK(BuildContext context, String msg){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Text(msg),
          actions: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
              color: Colors.blue,
            ),
          ],
        ));
  }

  static void showError(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          title: Text(
            'Lỗi !',
            style: TextStyle(color: Colors.red),
          ),
          content: Text('Đã xảy ra lỗi'),
          actions: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
              color: Colors.red,
            ),
          ],
        ));
  }
}
