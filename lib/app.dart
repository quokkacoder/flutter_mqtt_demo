import 'package:mqtt_demo/mqtt_bloc/bloc.dart';
import 'package:mqtt_demo/views/connection_page/init_page.dart';
import 'package:mqtt_demo/views/widgets/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/home/bloc/bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TopicsBloc()
            ..add(InitTopics()),
        ),
        BlocProvider(
          create: (context) => MQTTBloc()..add(InitMQTTService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo MQTT',
        theme: ThemeData(primaryColor: Colors.blue),
        home: BlocBuilder<MQTTBloc, MQTTState>(builder: (context, state) {
          if (state is HasInitializedMQTT) {
            return ConnectionPage();
          }
          return LoadingWidget();
        }),
      ),
    );
  }
}
