// This file is dual-licensed under GPLv3 and Commercial License
// See the LICENSE file in the project root for license information.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Accessible App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 24.0),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
