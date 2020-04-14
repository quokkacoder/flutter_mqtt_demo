import 'package:mqtt_demo/mqtt_bloc/bloc.dart';
import 'package:mqtt_demo/views/home/bloc/bloc.dart';
import 'package:mqtt_demo/views/home/home.dart';
import 'package:mqtt_demo/views/widgets/widget/error_widget.dart';
import 'package:mqtt_demo/views/widgets/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'init_page.dart';

class BuildHomePage extends StatelessWidget {
  MQTTBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<MQTTBloc>(context);

    return Scaffold(
        body: BlocConsumer<MQTTBloc, MQTTState>(listener: (bloc, state) {
      if (state is DisconnectedMQTT) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => ConnectionPage()));
      }
    }, builder: (context, state) {
      if (state is ConnectedMQTT) {
        return HomePage();
      } else if (state is ErrorState) {
        return AppErrorWidget('Can not connect to MQTT',() {
          _bloc.add(ConnectMQTTService());
        });
      }

      return LoadingWidget();
    }));
  }
}
