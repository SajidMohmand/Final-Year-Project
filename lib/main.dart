import 'package:flutter/material.dart';
import 'package:fyp2/providers/form_provider.dart';
import 'package:fyp2/providers/lawyer_provider.dart';
import 'package:fyp2/providers/profile_provider.dart';
import 'package:fyp2/providers/request_provider.dart';
import 'package:provider/provider.dart';
import 'views/splash_screen.dart';
import 'providers/slider_provider.dart';
import 'providers/register_provider.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SliderProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LawyerProvider()),
        ChangeNotifierProvider(create: (context) => FormProvider()),
        ChangeNotifierProvider(create: (context) => RequestProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF6D4905),
        fontFamily: 'OpenSans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
