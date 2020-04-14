import 'package:get_it/get_it.dart';
import 'mqtt_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<MQTTService>(() => MQTTService());
}