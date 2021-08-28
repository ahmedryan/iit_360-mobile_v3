import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm'),
      ),
    );
  }
}
