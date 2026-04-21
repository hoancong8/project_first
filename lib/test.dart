import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(
        onToggleTheme: () {
          setState(() {
            isDark = !isDark;
          });
        },
      ),
    );
  }
}




class HomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const HomePage({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo didChangeDependencies")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: MyWidget()),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: onToggleTheme,
            child: Text("Đổi Theme"),
          ),
        ],
      ),
    );
  }
}




class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  @override
  void initState() {
    super.initState();
    print("initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final brightness = Theme.of(context).brightness;

    print("didChangeDependencies: $brightness");
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      isDark ? "Dark Mode 🌙" : "Light Mode ☀️",
      style: TextStyle(fontSize: 24),
    );
  }
}