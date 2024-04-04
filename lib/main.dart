import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _status = "Not Started";
  Color _circleColor = Colors.red;
  String _stopwatchTime = "00:00:00";
  final Stopwatch _stopwatch = Stopwatch();
  final Random _random = Random();

void _changeState() {
  setState(() {
    if (_status == "Not Started") {
      _circleColor = Colors.red;
      _status = "Get Ready";
      int randomMillis = _random.nextInt(2700) + 300;
      Future.delayed(Duration(milliseconds: randomMillis), () {
        setState(() {
          _status = "Go!";
          _circleColor = Colors.green;
          _stopwatch.start();
        });
      });
    } else if (_status == "Go!") {
      _stopwatch.stop();
      _circleColor = Colors.red;
      _status = "Not Started";
      _stopwatchTime = '${_stopwatch.elapsed.inMilliseconds}ms';
      _stopwatch.reset();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jump Start App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _changeState,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: _circleColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Status: $_status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Time: $_stopwatchTime',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}