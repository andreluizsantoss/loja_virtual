import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as orientacao;

import 'firebase/firebase_options.dart';
import 'push_notification/push_notification.dart';

class ApplicationStartConfig {
  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    orientacao.SystemChrome.setPreferredOrientations(
        [orientacao.DeviceOrientation.portraitUp]);
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Color(0xFF047D8D),
    //   ),
    // );
    await _firebaseConfig();
    await _pushNotification();
  }

  Future<void> _firebaseConfig() async => await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

  Future<void> _pushNotification() => PushNotification().configure();
}
