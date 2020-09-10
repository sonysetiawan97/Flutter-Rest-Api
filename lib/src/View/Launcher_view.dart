import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterrestapi/src/View/HomePage_view.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    var duration = const Duration(seconds: 1);
    return new Timer(duration, () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
        return new HomeScreen();
      }));
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset(
          "assets/Planets.jpg",
          height: 500,
          width: 300,
        ),
      ),
    );
  }
}
