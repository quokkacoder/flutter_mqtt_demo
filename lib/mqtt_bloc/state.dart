import 'package:mqtt_demo/model/room.dart';
import 'package:equatable/equatable.dart';

abstract class MQTTState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingState extends MQTTState{}

class HasInitializedMQTT extends MQTTState{}

class ConnectedMQTT extends MQTTState{}

class DisconnectedMQTT extends MQTTState{}

class ErrorState extends MQTTState{}
