import 'package:flutter/material.dart';
import 'package:gods_eye/gods_eye.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  // <-- The first Screen
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    firstFunction(); // <-- Call the function in the initState()
    super.initState();
  }

  firstFunction() async {
    // <-- make the function
    GodsEye godsEye = GodsEye(godsEyeID: '###############');
    await godsEye.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(); // <-- Scaffold. Your Code begins here
  }
}
