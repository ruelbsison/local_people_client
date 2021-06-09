import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';
import 'app.dart';
//import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  //ClientApp.initSystemDefault();
  //await di.init();
  ClientApp.setupLogging();
  runApp(
    AppConfig(
      appName: AppLocalizations().clientAppTitle,
      appType: AppType.CLIENT,
      debugTag: true,
      flavorName: "dev",
      child: ClientApp.runWidget(AppType.CLIENT,),
    ),
  );
}
