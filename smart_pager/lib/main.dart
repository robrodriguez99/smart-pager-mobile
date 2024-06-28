
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_pager/bootstrap.dart';
import 'package:smart_pager/config/router.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pager/data/services/firebase_messaging.dart';


void main() async {
  await dotenv.load(fileName: ".env" ); //path to your .env fil
  await bootstrap();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessagingApi().init();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with RouterMixin {
  @override
  Widget build(BuildContext context) {
  

    return MaterialApp.router(
      routerConfig: router,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: SPColors.primary),
        useMaterial3: true,
      ),
    );
  }
}
