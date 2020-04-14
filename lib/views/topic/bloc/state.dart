import 'package:mqtt_demo/model/message.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatLoading extends ChatState{}

class ChatError extends ChatState{}

class SubscribedSuccess extends ChatState{
  final List<Message> msgs;

  SubscribedSuccess(this.msgs);

  @override
  // TODO: implement props
  List<Object> get props => [msgs];
}

class SubscribedFailed extends ChatState{}

class UnSubscribedFailed extends ChatState{}

class SendMsgFailed extends ChatState{}
