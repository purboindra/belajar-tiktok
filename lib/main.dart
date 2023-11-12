import 'package:belajar_tiktok/learn/riverpod/connection_handler/connection_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const ConnectionHandler(),
    );
  }
}
