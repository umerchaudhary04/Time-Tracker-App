import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/time_entry_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    // Wrapping the app in a MultiProvider (or ChangeNotifierProvider) 
    // ensures the state is available throughout the entire application.
    ChangeNotifierProvider(
      create: (context) => TimeEntryProvider(),
      child: const TimeTrackerApp(),
    ),
  );
}

class TimeTrackerApp extends StatelessWidget {
  const TimeTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Setting the initial route to our HomeScreen
      home: HomeScreen(), 
    );
  }
}