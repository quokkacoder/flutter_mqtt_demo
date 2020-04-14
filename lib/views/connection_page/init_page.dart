import 'package:mqtt_demo/mqtt_bloc/bloc.dart';
import 'package:mqtt_demo/views/home/bloc/topic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connection_page.dart';

class ConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RaisedButton.icon(
        color: Colors.blue,
        textColor: Colors.white,
        icon: Icon(Icons.near_me),
        onPressed: () {
          BlocProvider.of<MQTTBloc>(context)
              .add(ConnectMQTTService());
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => BuildHomePage()));
        },
        label: Text(
          'Connect to MQTT Server',
        ),
      ),
    ));
  }
}
