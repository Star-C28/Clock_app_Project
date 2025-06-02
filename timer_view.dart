import 'package:flutter/material.dart';
import 'dart:async';

class TimerView extends StatefulWidget {
  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  int seconds = 60;
  Timer? timer;
  bool isRunning = false;

  void startTimer() {
    if (isRunning) return;
    setState(() => isRunning = true);

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        timer.cancel();
        setState(() => isRunning = false);
      }
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    setState(() => isRunning = false);
  }

  void resetTimer() {
    stopTimer();
    setState(() => seconds = 60);
  }

  void setTime(int newSeconds) {
    setState(() {
      seconds = newSeconds.clamp(0, 600); // clamp to avoid errors
    });
  }

  String formatTime(int secs) {
    final minutes = (secs ~/ 60).toString().padLeft(2, '0');
    final remainingSecs = (secs % 60).toString().padLeft(2, '0');
    return "$minutes:$remainingSecs";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 25, 34),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Timer',
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
            SizedBox(height: 40),
            Text(
              formatTime(seconds),
              style: TextStyle(color: Colors.white, fontSize: 64),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startTimer,
                  child: Text("Start"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: stopTimer,
                  child: Text("Stop"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text("Reset"),
                ),
              ],
            ),
            SizedBox(height: 40),
            Slider(
              value: seconds.clamp(0, 600).toDouble(),
              min: 0,
              max: 600,
              divisions: 60,
              label: "${seconds ~/ 60} min",
              onChanged: isRunning
                  ? null
                  : (val) {
                      setTime(val.toInt());
                    },
            ),
          ],
        ),
      ),
    );
  }
}
