import 'package:mqtt_demo/views/home/bloc/bloc.dart';
import 'package:mqtt_demo/views/topic/bloc/bloc.dart';
import 'package:mqtt_demo/model/message.dart';
import 'package:mqtt_demo/model/room.dart';
import 'package:mqtt_demo/views/topic/bloc/chat_bloc.dart';
import 'package:mqtt_demo/views/widgets/dialog/alert_dialog.dart';
import 'package:mqtt_demo/views/widgets/widget/error_widget.dart';
import 'package:mqtt_demo/views/widgets/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

class LogTopicPage extends StatefulWidget {
  final AppTopic _topic;

  LogTopicPage(this._topic);

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogTopicPage> {
  ChatBloc _chatBloc;
  final _ctrlMsg = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _chatBloc.add(SubscribeTopic(widget._topic));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _chatBloc.add(UnSubscribeTopic(widget._topic.topic));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Topic ${widget._topic.name}'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () =>
                  MyAlertDialog.showDeleteTopic(context, widget._topic.name, (){
                    BlocProvider.of<TopicsBloc>(context).add(RemoveTopic(widget._topic));
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
        body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          if (state is SubscribedSuccess) {
            return Stack(
              children: <Widget>[
                _buildBody(state.msgs),
                _buildChatBox(),
              ],
            );
          } else if (state is SubscribedFailed) {
            return AppErrorWidget(
                'Can not subscribe topic: ${widget._topic.topic}', () {
              _chatBloc.add(UnSubscribeTopic(widget._topic.topic));
            });
          } else if (state is SendMsgFailed) {
            return AppErrorWidget('An error occurred while sending the message',
                _handlingSendMsg);
          }
          return LoadingWidget();
        }));
  }

  _buildBody(List<Message> msgs) {
    return msgs.isEmpty
        ? Center(
            child: Text('Empty'),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: msgs.length + 1,
                itemBuilder: (context, index) => index == msgs.length
                    ? SizedBox(
                        height: 100,
                      )
                    : Card(
                        color: Colors.grey[300],
                        elevation: 5,
                        child: ListTile(
                          title: Text(msgs[index].mess),
                          subtitle: Text(msgs[index].time),
                          trailing: Text('QoS: ${msgs[index].qos.index}'),
                        ),
                      )),
          );
  }

  _buildChatBox() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        color: Colors.blue,
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: TextFormField(
                controller: _ctrlMsg,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter some text...',
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () => _handlingSendMsg(),
            )
          ],
        ),
      ),
    );
  }

  _handlingSendMsg() {
    final string = _ctrlMsg.text.trim();
    if (string.isNotEmpty) {
      _chatBloc.add(SendMessage(Message(
          mess: string, topic: widget._topic.topic, qos: MqttQos.atLeastOnce)));
      _ctrlMsg.clear();
    } else {
      MyAlertDialog.showAlertOK(context, 'Please enter some text !');
    }
  }
}
