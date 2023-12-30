import 'package:belajar_tiktok/learn/learn_theme/theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    FlutterError.dumpErrorToConsole(errorDetails);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_outlined,
                color: Colors.red,
                size: 100,
              ),
              Text(errorDetails.exceptionAsString().isNotEmpty
                  ? errorDetails.exceptionAsString()
                  : 'Sorry, something went wrong'),
            ],
          ),
        ),
      ),
    );
  };

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        shadowColor: Colors.grey.shade900,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 37, 36, 36),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(199, 242, 135, 224),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        primaryColor: const Color.fromARGB(199, 242, 135, 240),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
        ),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 242, 135, 242),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        primaryColor: const Color.fromARGB(255, 237, 135, 242),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.white),
        ),
      ),
      home: ThemeScreen(),
    );
  }
}
