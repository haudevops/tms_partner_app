import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'config/configuration_dev.dart';
import 'main.dart';

void main() async {
  GlobalConfiguration().loadFromMap(debugAppSettings);
  // WidgetsFlutterBinding.ensureInitialized();
  // Widget app = await initializeApp();
  // runApp(app);
}