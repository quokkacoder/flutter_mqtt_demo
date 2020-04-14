import 'package:mqtt_demo/mqtt_bloc/bloc.dart';
import 'package:mqtt_demo/utils/get_it.dart';
import 'package:mqtt_demo/utils/mqtt_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MQTTBloc extends Bloc<MQTTEvent, MQTTState> {
  final _mqttService = locator<MQTTService>();

  @override
  // TODO: implement initialState
  MQTTState get initialState => LoadingState();

  @override
  Stream<MQTTState> mapEventToState(MQTTEvent event) async* {
    if (event is InitMQTTService) {
      _mqttService.initMQTT();
      yield HasInitializedMQTT();
    } else if (event is ConnectMQTTService) {
      yield* _connectMQTT(event);
    } else if (event is DisconnectMQTTT) {
      _mqttService.disconnectMQTT();
      yield DisconnectedMQTT();
    }
  }

  Stream<MQTTState> _connectMQTT(ConnectMQTTService event) async* {
    yield LoadingState();
    try {
      await _mqttService.connectMQTT();
      if (_mqttService.client.connectionStatus.state ==
          MqttConnectionState.connected) {
        yield ConnectedMQTT();
      } else {
        debugPrint(
            'Client exception, status is ${_mqttService.client.connectionStatus}');
        _mqttService.disconnectMQTT();
        yield ErrorState();
      }
    } on Exception catch (e) {
      debugPrint('Client exception - $e');
      _mqttService.disconnectMQTT();
      yield ErrorState();
    }
  }
}
