import 'package:cocosmartapp/provider/auth_provider/auth_provider.dart';
import 'package:cocosmartapp/provider/estate_provider/land_provider.dart';
import 'package:cocosmartapp/provider/location_provider/location_provider.dart';
import 'package:cocosmartapp/provider/weather_provider/weather_provider.dart';
import 'package:cocosmartapp/screens/authentication_screen/estate_registration/estate_location_screen.dart';
import 'package:cocosmartapp/screens/dashboard_screen/dashboard_screen.dart';
import 'package:cocosmartapp/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_resources/color_resources.dart';
import 'firebase_options/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AuthProvider()),
        ChangeNotifierProvider(create: (context)=>WeatherProvider()),
        ChangeNotifierProvider(create: (contect)=>LocationProvider()),
        ChangeNotifierProvider(create: (contect)=>LandProvider())
      ],
      child: const MyApp())
  );
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