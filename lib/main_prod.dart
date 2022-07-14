import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'config/configuration_prod.dart';

void main() async {
  GlobalConfiguration().loadFromMap(productAppSettings);

  // Widget app = await initializeApp();
  // runApp(app);
}