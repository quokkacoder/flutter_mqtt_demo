
import 'package:mqtt_demo/model/message.dart';
import 'package:mqtt_demo/model/room.dart';
import 'package:mqtt_demo/views/home/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateMessageARoom extends ChatEvent{
  final Message mess;

  UpdateMessageARoom(this.mess);

  @override
  // TODO: implement props
  List<Object> get props => [mess];
}

class SendMessage extends ChatEvent{
  final Message message;

  SendMessage(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class SubscribeTopic extends ChatEvent{
  final AppTopic topic;

  SubscribeTopic(this.topic,);

  @override
  // TODO: implement props
  List<Object> get props => [topic];
}

class UnSubscribeTopic extends ChatEvent{
  final String nameTopic;

  UnSubscribeTopic(this.nameTopic);

  @override
  // TODO: implement props
  List<Object> get props => [nameTopic];
}