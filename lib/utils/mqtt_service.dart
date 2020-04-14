import 'dart:math';

import 'package:mqtt_demo/model/message.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTService{
  MqttServerClient _client;

  MqttServerClient get client => _client;

  final String _host = 'broker.hivemq.com';
  final int _port = 1883;
  final String _clientIdentifier = 'f_demo${Random().nextInt(99)}';
  final int _keepAlivePeriod = 60;
  final bool _autoReconnect = true;

  void _onConnected(){
    debugPrint('>>> Connected');
  }

  void _onDisconnected(){
    debugPrint('>>> Client disconnection');
  }

  void _onSubscribed(String topic) {
    debugPrint('>>> Subscription $topic');
  }

  void _onUnsubscribed(String topic) {
    debugPrint('>>> UnSubscription $topic');
  }
  /// Pong callback
  void _pong() {
    debugPrint('>>> Ping response client callback invoked');
  }

  void initMQTT() {
    _client = MqttServerClient(_host, '');
    _client.port = _port;
    _client.onConnected = _onConnected;
    _client.keepAlivePeriod = _keepAlivePeriod;
    // _client.logging(on: true); // logging if u want
    _client.onDisconnected = _onDisconnected;
    _client.onSubscribed = _onSubscribed;
    _client.onUnsubscribed = _onUnsubscribed;
    _client.autoReconnect = _autoReconnect;
    _client.pongCallback = _pong;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(_clientIdentifier)
        .keepAliveFor(20) // Must agree with the keep alive set above or not set
        .withWillTopic(
        'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atMostOnce);
    _client.connectionMessage = connMess;
  }

  connectMQTT() async {
    try {
      await _client.connect();
    } on Exception catch (e) {
      _client.disconnect();
      throw Exception('Client MQTT exception - $e');
    }
  }

  disconnectMQTT() => _client.disconnect();

  sendMessage(Message message){
    try {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message.mess);
      _client.publishMessage(
          message.topic, message.qos, builder.payload);
    }catch(e){
      throw Exception(e.toString());
    }
  }
}