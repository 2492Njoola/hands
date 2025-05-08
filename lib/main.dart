import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hands_test/core/services/firebase_api.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // await initializeAgora();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  // made by
  runApp(const MyApp());
}
// Interpreter
// c10qsMrDT8aaTQQGzYvrls:APA91bFhw3t74LOoh4xru_4gnTuDqNnQFbJPbQBWbihNVZQaAvRKMA2Uq6DK
