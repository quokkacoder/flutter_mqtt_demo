import 'package:equatable/equatable.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Message extends Equatable {
  String mess;
  String topic;
  String time;
  MqttQos qos;

  Message({this.mess, this.topic, this.qos,}){
    this.time = DateTime.now().toString();
  }

  @override
  // TODO: implement props
  List<Object> get props => [topic, qos, mess];
}