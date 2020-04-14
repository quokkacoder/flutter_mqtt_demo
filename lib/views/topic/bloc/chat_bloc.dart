import 'package:mqtt_demo/views/topic/bloc/bloc.dart';
import 'package:mqtt_demo/model/message.dart';
import 'package:mqtt_demo/utils/get_it.dart';
import 'package:mqtt_demo/utils/mqtt_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_demo/views/home/bloc/bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _mqttService = locator<MQTTService>();
  final TopicsBloc _topicsBloc;

  ChatBloc(this._topicsBloc);

  @override
  // TODO: implement initialState
  ChatState get initialState => ChatLoading();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is SendMessage) {
      yield* _sendMessage(event);
    } else if (event is SubscribeTopic) {
      yield* _subscribeTopic(event);
    } else if (event is UnSubscribeTopic) {
      yield* _unSubscribeTopic(event);
    } else if (event is UpdateMessageARoom) {
      yield* _updateMessage(event);
    }
  }

  Stream<ChatState> _subscribeTopic(SubscribeTopic event) async* {
    try {
      if (_mqttService.client.connectionStatus.state ==
          MqttConnectionState.connected) {
        _mqttService.client.subscribe(event.topic.topic, event.topic.qos);
        _mqttService.client.updates
            .listen((List<MqttReceivedMessage<MqttMessage>> c) {
          if (state is SubscribedSuccess) {
            final MqttPublishMessage recMess = c[0].payload;
            final pt = MqttPublishPayload.bytesToStringAsString(
                recMess.payload.message);

            debugPrint(
                '>>> Change notification - topic: <${c[0]
                    .topic}>, payload: <-- $pt -->');

            final mess = Message(
              mess: pt,
              topic: c[0].topic,
              qos: recMess.payload.header.qos,
            );
            this.add(UpdateMessageARoom(mess));
          }
        });
        yield SubscribedSuccess(event.topic.mess);
      } else {
        yield SubscribedFailed();
      }
    } catch (e) {
      yield SubscribedFailed();
    }
  }

  Stream<ChatState> _unSubscribeTopic(UnSubscribeTopic event) async* {
    try {
      _mqttService.client.unsubscribe(event.nameTopic);
    } catch (e) {
      yield UnSubscribedFailed();
    }
  }

  Stream<ChatState> _sendMessage(SendMessage event) async* {
    try {
      _mqttService.sendMessage(event.message);
      yield (state as SubscribedSuccess);
    } catch (e) {
      yield SendMsgFailed();
    }
  }

  Stream<ChatState> _updateMessage(UpdateMessageARoom event) async*{
    final List<Message> updatedMsgs =
    List.from((state as SubscribedSuccess).msgs)..insert(0, event.mess);
    yield SubscribedSuccess(updatedMsgs);
  }
}
