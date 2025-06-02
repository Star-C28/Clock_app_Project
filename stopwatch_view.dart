import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchView extends StatefulWidget {
  @override
  _StopwatchViewState createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView> {
  late Stopwatch stopwatch;
  late Timer timer;
  String elapsedTime = "00:00:00";

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      if (stopwatch.isRunning) {
        setState(() {
          elapsedTime = _formatTime(stopwatch.elapsedMilliseconds);
        });
      }
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();

    String h = hours.toString().padLeft(2, '0');
    String m = (minutes % 60).toString().padLeft(2, '0');
    String s = (seconds % 60).toString().padLeft(2, '0');

    return "$h:$m:$s";
  }

  void startStopwatch() {
    stopwatch.start();
  }

  void stopStopwatch() {
    stopwatch.stop();
  }

  void resetStopwatch() {
    stopwatch.reset();
    setState(() {
      elapsedTime = "00:00:00";
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 25, 34),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stopwatch',
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
            SizedBox(height: 40),
            Text(
              elapsedTime,
              style: TextStyle(color: Colors.white, fontSize: 64),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startStopwatch,
                  child: Text("Start"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: stopStopwatch,
                  child: Text("Stop"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetStopwatch,
                  child: Text("Reset"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
