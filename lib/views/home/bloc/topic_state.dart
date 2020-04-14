
import 'package:mqtt_demo/model/room.dart';
import 'package:equatable/equatable.dart';

abstract class TopicsState extends Equatable{
  const TopicsState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TopicsLoading extends TopicsState{}

class ActionLoading extends TopicsState{}

class ActionSuccess extends TopicsState{}

class TopicsLoaded extends TopicsState{
  final List<AppTopic> topics;

  const TopicsLoaded(this.topics);

  @override
  // TODO: implement props
  List<Object> get props => [topics];

}

class TopicsError extends TopicsState{}