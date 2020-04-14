
import 'package:mqtt_demo/utils/get_it.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc_delegate.dart';


main() async {
  setupLocator(); // setup get it : mqtt service
  BlocSupervisor.delegate = AppBlocDelegate(); // setup logging bloc
  runApp(MyApp());
}
