import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wac_task/core/utils/custom_http_override_class.dart';

import 'package:wac_task/them_config.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
