import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'app.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ClientApp.initSystemDefault();
  await di.init();
  ClientApp.setupLogging();
  runApp(
    AppConfig(
      appName: AppLocalizations().clientAppTitle,
      debugTag: true,
      flavorName: "dev",
      child: ClientApp(),
    ),
  );
}
