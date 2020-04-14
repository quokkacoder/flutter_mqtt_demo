import 'package:mqtt_demo/model/room.dart';
import 'package:equatable/equatable.dart';

abstract class TopicsEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitTopics extends TopicsEvent{}

class CreateTopic extends TopicsEvent{
  final AppTopic topic;

  CreateTopic(this.topic);

  @override
  // TODO: implement props
  List<Object> get props => [topic];
}

class RemoveTopic extends TopicsEvent{
  final AppTopic topic;

  RemoveTopic(this.topic);

  @override
  // TODO: implement props
  List<Object> get props => [topic];
}