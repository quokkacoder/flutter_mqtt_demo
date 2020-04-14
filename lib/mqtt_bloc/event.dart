import 'package:mqtt_demo/views/home/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class MQTTEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitMQTTService extends MQTTEvent{}

class DisconnectMQTTT extends MQTTEvent{}

class ConnectMQTTService extends MQTTEvent{}
