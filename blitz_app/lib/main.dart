import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grade_project_1765532/firebase_options.dart';

import 'src/core/logic/shared_preferences.dart';
import 'src/mate_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  final prefs = Preferences();
  await prefs.init();
  runApp(const MyApp());
}
