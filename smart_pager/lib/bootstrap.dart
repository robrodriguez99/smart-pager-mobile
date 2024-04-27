
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

 
  PlatformDispatcher.instance.onError = (error, stack) {
    return true;
  };
}
