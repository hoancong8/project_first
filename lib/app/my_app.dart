import 'package:flutter/material.dart';
import 'app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: AppTheme.lightTheme,
      home: const Scaffold(body: Center(child: Text('Hello World'))),
    );
  }
}
