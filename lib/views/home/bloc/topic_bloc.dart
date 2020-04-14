import 'package:mqtt_demo/model/room.dart';
import 'package:mqtt_demo/views/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {

  @override
  // TODO: implement initialState
  TopicsState get initialState => TopicsLoading();

  @override
  Stream<TopicsState> mapEventToState(TopicsEvent event) async* {
    if (event is InitTopics) {
      yield TopicsLoaded([]);
    } else if (event is CreateTopic) {
      yield* _createTopic(event);
    } else if (event is RemoveTopic) {
      yield* _removeTopic(event);
    }
  }

  Stream<TopicsState> _createTopic(CreateTopic event) async* {
    if (state is TopicsLoaded) {
      yield ActionLoading();

      final List<AppTopic> updateTopics = List.from(
          (state as TopicsLoaded).topics)
        ..insert(0, event.topic);
      yield ActionSuccess();
      yield TopicsLoaded(updateTopics);
    }
  }

  Stream<TopicsState> _removeTopic(RemoveTopic event) async*{
    yield ActionLoading();

    final List<AppTopic> updateTopics = List.from(
        (state as TopicsLoaded).topics)
      ..remove(event.topic);
    yield ActionSuccess();
    yield TopicsLoaded(updateTopics);
  }
}
