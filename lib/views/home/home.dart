import 'package:mqtt_demo/views/topic/bloc/bloc.dart';
import 'package:mqtt_demo/mqtt_bloc/bloc.dart';
import 'package:mqtt_demo/model/room.dart';
import 'package:mqtt_demo/views/home/bloc/bloc.dart';
import 'package:mqtt_demo/views/topic/log_topic_page.dart';
import 'package:mqtt_demo/views/widgets/dialog/alert_dialog.dart';
import 'package:mqtt_demo/views/widgets/dialog/loading_dialog.dart';
import 'package:mqtt_demo/views/widgets/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  TopicsBloc _topicsBloc;

  @override
  Widget build(BuildContext context) {
    _topicsBloc = BlocProvider.of<TopicsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Topics'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.subdirectory_arrow_left),
              onPressed: () => MyAlertDialog.showDisconnect(context, () {
                    BlocProvider.of<MQTTBloc>(context).add(DisconnectMQTTT());
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => MyAlertDialog.showCreateTopic(context),
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<TopicsBloc, TopicsState>(listener: (context, state) {
        if (state is ActionLoading) {
          LoadingDialog.show(context);
        } else if (state is ActionSuccess) {
          LoadingDialog.hidden(context);
        }
      }, builder: (context, state) {
        if (state is TopicsLoaded) {
          if (state.topics.isEmpty) {
            return Center(
              child: Text('Let\'s create a Topic'),
            );
          }
          return _buildTopics(state.topics);
        }
        return LoadingWidget();
      }),
    );
  }

  _buildTopics(List<AppTopic> topics) {
    return ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return _itemTopic(topics[index], context);
        });
  }

  _itemTopic(AppTopic topic, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider(
                    create: (context) => ChatBloc(_topicsBloc),
                    child: LogTopicPage(
                      topic,
                    ))));
      },
      child: ListTile(
        title: Text(topic.name),
        trailing: IconButton(
          onPressed: () =>
              MyAlertDialog.showDeleteTopic(context, topic.name, () {
            _topicsBloc.add(RemoveTopic(topic));
          }),
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
