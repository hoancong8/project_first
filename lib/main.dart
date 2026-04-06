import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/screen/login/login_screen.dart';

void main() {
  runApp(
    // 1. Bao bọc ứng dụng bằng ProviderScope để Riverpod hoạt động
    const ProviderScope(
      child: MaterialApp(
        home: LoginScreen(),
      ),
    ),
  );
}
