import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cocosmartapp/helpers/notification_helpers.dart';
import 'package:cocosmartapp/provider/auth_provider/auth_provider.dart';
import 'package:cocosmartapp/provider/disease_provider/disease_provider.dart';
import 'package:cocosmartapp/provider/estate_provider/land_provider.dart';
import 'package:cocosmartapp/provider/healthScore_provider/health_scoreProvider.dart';
import 'package:cocosmartapp/provider/irigation_provider/irigation_recommender_provider.dart';
import 'package:cocosmartapp/provider/location_provider/location_provider.dart';
import 'package:cocosmartapp/provider/notification_provider/notification_provider.dart';
import 'package:cocosmartapp/provider/weather_provider/weather_provider.dart';
import 'package:cocosmartapp/provider/yield_prediction_provider/yield_prediction_provider.dart';
import 'package:cocosmartapp/screens/authentication_screen/estate_registration/estate_location_screen.dart';
import 'package:cocosmartapp/screens/dashboard_screen/dashboard_screen.dart';
import 'package:cocosmartapp/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_resources/color_resources.dart';
import 'firebase_options/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AndroidAlarmManager.initialize();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AuthProvider()),
        ChangeNotifierProvider(create: (context)=>WeatherProvider()),
        ChangeNotifierProvider(create: (contect)=>LocationProvider()),
        ChangeNotifierProvider(create: (contect)=>LandProvider()),
        ChangeNotifierProvider(create: (contect)=>IrrigationRecommenderProvider()),
        ChangeNotifierProvider(create: (contect)=>YieldPredictionProvider()),
        ChangeNotifierProvider(create: (contect)=>NotificationProvider()),
        ChangeNotifierProvider(create: (contect)=>DiseaseProvider()),
        ChangeNotifierProvider(create: (contect)=>HealthScoreprovider())
      ],
      child: const MyApp())
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COCO Smart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: ColorResources.MAIN_BACKGROUND_COLOR),
      ),
      home: SplashScreen()
    );
  }
}