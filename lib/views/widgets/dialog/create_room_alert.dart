import 'package:mqtt_demo/model/room.dart';
import 'package:mqtt_demo/views/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

class CreateRoomWidget extends StatelessWidget {
  final _ctrlName = TextEditingController();
  final _ctrlID = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicsBloc, TopicsState>(
      listener: (context, state){
        if(state is ActionSuccess){
          Navigator.pop(context);
        }
      },
      builder:(context, state)=> Form(
        key: _formKey,
        child: AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Create new room',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextFormField(
                controller: _ctrlID,
                decoration: InputDecoration(
                  hintText: 'ID',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ctrlName,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCEL'),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () => _createRoom(context),
              child: Text('OK'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  _createRoom(BuildContext context) {
    if (_formKey.currentState.validate()) {
      final room = AppTopic(
          _ctrlName.text.trim(), _ctrlID.text.trim(), MqttQos.atLeastOnce);
      BlocProvider.of<TopicsBloc>(context)
          .add(CreateTopic(room));
    }
  }
}
