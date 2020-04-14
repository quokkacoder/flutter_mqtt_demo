import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final Function _function;
  final String _msg;

  const AppErrorWidget(this._msg, this._function);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_msg),
          RaisedButton(
            child: Text('Try again'),
            onPressed: _function,
          ),
        ],
      ),
    );
  }
}
