import 'package:mqtt_demo/model/message.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_client/mqtt_client.dart';

class AppTopic extends Equatable {
  String name;
  String topic;
  MqttQos qos;
  List<Message> mess = List();

  AppTopic(this.name, this.topic, this.qos,);

  @override
  // TODO: implement props
  List<Object> get props => [name, topic, qos, mess];
}